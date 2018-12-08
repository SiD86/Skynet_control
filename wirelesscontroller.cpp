#include <QMessageBox>
#include <QTimer>
#include <QApplication>
#include "wirelesscontroller.h"
#include "TXRX_PROTOCOL.h"
#define SEND_PACKET_INTERVAL_MS				(100)
#define SERVER_IP_ADDRESS					("111.111.111.111")
#define SERVER_PORT							(3333)

const int PACKET_SIZE = sizeof(TXRX::fly_controller_packet_t);
const int DATA_SIZE = sizeof(TXRX::fly_controller_packet_t::data);

//
// PUBLIC
//
WirelessController::WirelessController(QObject* parent) : QObject(parent) {
	m_txDataAddress = nullptr;
	m_rxDataAddress = nullptr;
	m_txCount = 0;
	m_rxCount = 0;
	m_errorCount = 0;
	m_skipCount = 0;
}

void WirelessController::initialize(quint8* txData, quint8* rxData) {

	m_txDataAddress = txData;
	m_rxDataAddress = rxData;

	// Initialize UDP socket
	connect(&m_UDPSocket, SIGNAL(readyRead()), SLOT(UDPRecv()));

	// Initialize send packet timer
	m_sendTimer.setInterval(SEND_PACKET_INTERVAL_MS);
	connect(&m_sendTimer, SIGNAL(timeout()), SLOT(UDPSend()));
}

bool WirelessController::start() {

	// Setup socket
	if (m_UDPSocket.bind(SERVER_PORT, QUdpSocket::DontShareAddress) == false) {
		QMessageBox::critical(nullptr, "Ошибка", "Ошибка при подключении к порту");
		return false;
	}

	m_sendTimer.start();

	// Reset counters
	m_txCount = 0;
	m_rxCount = 0;
	m_errorCount = 0;
	m_skipCount = 0;
	return true;
}

void WirelessController::stop() {
	m_sendTimer.stop();
	m_UDPSocket.close();
}

bool WirelessController::runConnection() {

	if (this->start() == false)
		return false;

	QTimer timer;
	timer.setInterval(10000);
	timer.setSingleShot(true);
	timer.start();

	while (m_rxCount < 10) {

		QApplication::processEvents();

		if (timer.isActive() == false) {
			this->stop();
			return false;
		}
	}

	return true;
}

void WirelessController::stopConnection() {
	this->stop();
}


//
// PROTECTED
//
quint32 WirelessController::calcCRC(const quint8* data) {

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


//
// SLOTS
//
void WirelessController::UDPSend() {

	emit beginTxData();

	// Building packet
    TXRX::fly_controller_packet_t packet;
	memcpy(packet.data, m_txDataAddress, DATA_SIZE);
	packet.CRC = calcCRC(packet.data);

    // Send packet
    QHostAddress host_addr(SERVER_IP_ADDRESS);
	m_UDPSocket.writeDatagram((char*)&packet, PACKET_SIZE, host_addr, SERVER_PORT);

	// Update counters
	++m_txCount;
	emit updateCounters(m_txCount, m_rxCount, m_skipCount, m_errorCount);
}

void WirelessController::UDPRecv() {

	static int prev_packet_number = -1;

    // Read packet
    TXRX::fly_controller_packet_t packet;
	QHostAddress datagramAddress;
	m_UDPSocket.readDatagram((char*)&packet, PACKET_SIZE, &datagramAddress);

	// Check IP address
	if (datagramAddress.isEqual(QHostAddress(SERVER_IP_ADDRESS)) == false) {
		++m_errorCount;
		emit updateCounters(m_txCount, m_rxCount, m_skipCount, m_errorCount);
        return;
	}

	// Check CRC
	quint32 CRC = calcCRC(packet.data);
	if (packet.CRC != CRC) {
		++m_errorCount;
		emit updateCounters(m_txCount, m_rxCount,m_skipCount,  m_errorCount);
        return;
    }

	// Check packet number (for communication quality)
	if (prev_packet_number == -1)
		prev_packet_number = packet.number;

	if (prev_packet_number < packet.number) {

		if (prev_packet_number + 1 != packet.number) {
			m_skipCount += packet.number - prev_packet_number;
		}
		prev_packet_number = packet.number;
	}
	else {
		prev_packet_number = packet.number;
	}


    // Copy state data
	memcpy(m_rxDataAddress, packet.data, DATA_SIZE);

	// Update counters
	++m_rxCount;
	emit updateCounters(m_txCount, m_rxCount, m_skipCount, m_errorCount);

	// Start TX timer if need
	if (m_sendTimer.isActive() == false)
		m_sendTimer.start();

	emit dataRxSuccess();
}
