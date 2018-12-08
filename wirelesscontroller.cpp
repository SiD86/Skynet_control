#include <QApplication>
#include <QMessageBox>
#include <QTimer>
#include "wirelesscontroller.h"
#include "wireless_protocol.h"
#define SEND_INTERVAL_MS				(500)
#define SERVER_IP_ADDRESS				("111.111.111.111")
#define SERVER_PORT						(3333)


const int PACKET_SIZE = sizeof(wireless_protocol_frame_t);
const int DATA_SIZE = sizeof(wireless_protocol_frame_t::data);

static quint32 calculateCRC(const quint8* data);


//  ***************************************************************************
/// @brief	Wireless controller constructor
/// @param	parent: not use
/// @return	none
//  ***************************************************************************
WirelessController::WirelessController() : QObject(nullptr) {
	m_txDataAddress = nullptr;
	m_rxDataAddress = nullptr;
	m_txCounter = 0;
	m_rxCounter = 0;
	m_errorCounter = 0;
	m_skipCounter = 0;
}

//  ***************************************************************************
/// @brief	Wireless controller initialization
/// @param	txDataAddress: TX data address
/// @param	txDataAddress: RX data address
/// @return	none
//  ***************************************************************************
void WirelessController::init(quint8* txDataAddress, quint8* rxDataAddress) {

	m_txDataAddress = txDataAddress;
	m_rxDataAddress = rxDataAddress;

	// Setup UDP socket
	connect(&m_socket, &QUdpSocket::readyRead, this, &WirelessController::recv);

	// Setup send packet timer
	m_sendTimer.setInterval(SEND_INTERVAL_MS);
	connect(&m_sendTimer, &QTimer::timeout, this, &WirelessController::send);
}

//  ***************************************************************************
/// @brief	Start wireless communication
/// @param	none
/// @return	true - start success, false - no
//  ***************************************************************************
bool WirelessController::start() {

	if (m_socket.bind(SERVER_PORT, QUdpSocket::DontShareAddress) == false) {
		return false;
	}

	// Start send control data timer
	m_sendTimer.start();

	// Reset counters
	m_txCounter = 0;
	m_rxCounter = 0;
	m_errorCounter = 0;
	m_skipCounter = 0;

	return true;
}

//  ***************************************************************************
/// @brief	Stop wireless communication
/// @param	none
/// @return	none
//  ***************************************************************************
void WirelessController::stop() {
	m_sendTimer.stop();
	m_socket.close();
}



//  ***************************************************************************
/// @brief	Slot for send UPD data
/// @param	none
/// @return	none
//  ***************************************************************************
void WirelessController::send() {

	emit prepareTxData();

	// Building control frame
	wireless_protocol_frame_t frame;
	memcpy(frame.data, m_txDataAddress, DATA_SIZE);
	frame.CRC = calculateCRC(frame.data);

	// Send frame
	m_socket.writeDatagram(reinterpret_cast<char*>(&frame), sizeof(wireless_protocol_frame_t),
						   QHostAddress(SERVER_IP_ADDRESS), SERVER_PORT);

	// Update counters
	++m_txCounter;
	emit countersUpdated(m_txCounter, m_rxCounter, m_skipCounter, m_errorCounter);
}

//  ***************************************************************************
/// @brief	Slot for recv UPD data
/// @param	none
/// @return	none
//  ***************************************************************************
void WirelessController::recv() {

	static int prev_packet_number = -1;

    // Read packet
	wireless_protocol_frame_t frame;
	QHostAddress datagramAddress;
	m_socket.readDatagram(reinterpret_cast<char*>(&frame), sizeof(wireless_protocol_frame_t),
						  &datagramAddress);

	// Check IP address
	if (datagramAddress.isEqual(QHostAddress(SERVER_IP_ADDRESS)) == false) {
		++m_errorCount;
		emit updateCounters(m_txCount, m_rxCount, m_skipCount, m_errorCount);
        return;
	}

	// Check CRC
	if (frame.CRC != calcCRC(frame.data)) {
		++m_errorCount;
		emit updateCounters(m_txCount, m_rxCount,m_skipCount,  m_errorCount);
        return;
    }

	// Check packet number (for communication quality)
	if (prev_packet_number == -1)
		prev_packet_number = frame.number;

	if (prev_packet_number < frame.number) {

		if (prev_packet_number + 1 != frame.number) {
			m_skipCount += frame.number - prev_packet_number;
		}
		prev_packet_number = frame.number;
	}
	else {
		prev_packet_number = frame.number;
	}


    // Copy state data
	memcpy(m_rxDataAddress, frame.data, DATA_SIZE);

	// Update counters
	++m_rxCount;
	emit updateCounters(m_txCount, m_rxCount, m_skipCount, m_errorCount);

	// Start TX timer if need
	if (m_sendTimer.isActive() == false)
		m_sendTimer.start();

	emit dataRxSuccess();
}






static quint32 calculateCRC(const quint8* data) {

	quint32 CRC = 0;

	for (quint32 i = 0; i < DATA_SIZE; i += 2) {

		quint16 value = (data[i] << 8) | data[i + 1];
		if (value % 3 == 0)
			CRC |= 1 << (i + 0);

		if (value % 2 == 0)
			CRC |= 1 << (i + 1);
	}

	return CRC;
}
