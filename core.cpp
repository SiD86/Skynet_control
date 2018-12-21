#include <QQuickItem>
#include "core.h"
#include "version.h"

extern WirelessController g_wirelessController;

//
// PUBLIC
//
Core::Core() : QObject(nullptr) {
	memset(&m_controlData, 0, sizeof(m_controlData));
	memset(&m_stateData, 0, sizeof(m_stateData));
}

Core::~Core() {
	//delete m_logController;
	//delete m_joystick;
}

void Core::initialize(QQuickItem* rootObject) {

	// Initialize Wireless Controller
	g_wirelessController.init((quint8*)&m_controlData, (quint8*)&m_stateData);
	//connect(&g_wirelessController, SIGNAL(beginTxData()), SLOT(constructControlPacket()));
	//connect(&g_wirelessController, SIGNAL(dataRxSuccess()), SLOT(statePacketProcess()));
	/*connect(&g_wirelessController, &WirelessController::updateCounters, [this](int rx, int tx, int error) {
		emit wirelessControllerCountersUpdated(rx, tx, error);
	} );*/

	g_wirelessController.start();
	//emit updateQML();
}

//
// SLOTS
//
QVariant Core::getVersion() {
	return 0;//QString::number(MAIN_VERSION) + "." + QString::number(SUB_VERSION) + "." + QString::number(AUX_VERSION);
}

void Core::constructControlPacket() {

	// Clear packet
	/*memset(&m_controlData, 0, sizeof(m_controlData));

	// Disable quadcopter if joystick disconnected
	if (m_joystick->is_available() == false) {
		m_controlData.command = TXRX::CMD_SET_FLY_MODE_WAIT;
		return;
	}

    // Process joystick state
    JOYSTICK_STATE js = m_joystick->get_state();

    // Process command
	if (js.button & JOYSTICK_BUTTON_6) {
		m_controlData.command = TXRX::CMD_SET_FLY_MODE_ANGLE_PID_SETUP;
    }
	else if (js.button & JOYSTICK_BUTTON_8) {
		m_controlData.command = TXRX::CMD_SET_FLY_MODE_RATE_PID_SETUP;
	}
	else if (js.button & 0xFF){
		m_controlData.command = TXRX::CMD_SET_FLY_MODE_WAIT;
	}

	// Load PID parameters
	memcpy(m_controlData.PIDX, m_PID[0], sizeof(m_controlData.PIDX));
	memcpy(m_controlData.PIDY, m_PID[1], sizeof(m_controlData.PIDY));
	memcpy(m_controlData.PIDZ, m_PID[2], sizeof(m_controlData.PIDZ));

	// Get X,Y,Z and thrust
	m_controlData.XYZ[0] = js.XYZ[0];
	m_controlData.XYZ[1] = js.XYZ[1];
	m_controlData.XYZ[2] = js.XYZ[2];
	m_controlData.thrust = js.thrust;*/
}
