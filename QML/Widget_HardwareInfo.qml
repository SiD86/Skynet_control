import QtQuick 2.9
import QtQuick.Controls 2.3

Item {
	id: root
	width: 670
	height: 670
	clip: true

	property int motorWarningPower: 70
	property int motorCriticalPower: 85

	property int escWarningTemperature: 50
	property int escCriticalTemperature: 70

	function get_motor_status(p, t) {

		if (p >= motorCriticalPower)
			return 0 // Critical status
		else if (p >= motorWarningPower)
			return 2 // Warning status
		return 1 // Normal status
	}
	function get_ESC_status(t) {

		if (t >= escCriticalTemperature)
			return 0 // Critical status
		else if (t >= escWarningTemperature)
			return 2 // Warning status
		return 1 // Normal status
	}

	Image {
		x: 3
		y: 3
		width: 665
		height: 665
		smooth: false
		source: "qrc:/images/quadcopter.png"

		Label {
			x: 116
			y: 5
			width: 433
			height: 29
			color: "#aaaaaa"
			text: qsTr("NEO4X SKY: FW ver. 0.0.XX  HW ver. 0.0.XX")
			horizontalAlignment: Text.AlignHCenter
			font.pointSize: 16
		}
	}

	// Thrust
	CTRL_ProgressBarWithText {
		x: 17
		y: 107
		width: 20
		height: 459
		value: mainCore.thrust
		text_rotation: 90
		orientation: 0
	}

	// Front right motor information (1)
	CTRL_HardwareModuleStatus {
		x: 589
		y: 19
		width: 63
		height: 63
		smooth: false
		source: "qrc:/images/motor.png"
		status: get_motor_status(mainCore.motor1Power, 0)
	}

	CTRL_ProgressBarWithText {
		x: 537
		y: 53
		width: 20
		height: 140
		orientation: 0
		value: mainCore.motor1Power
		rotation: 45
		text_rotation: -90
		level_warning: motorWarningPower
		level_critical: motorCriticalPower
	}

	CTRL_Parameter {
		x: 460
		y: 251
		width: 100
		height: 55
		value: 0
		postfix: " °C"
		title: "Температура ESC"
		warning_value: escWarningTemperature
		critical_value: escCriticalTemperature
	}
	CTRL_HardwareModuleStatus {
		x: 430
		y: 166
		width: 75
		height: 75
		rotation: 0
		source: "qrc:/images/ESC.png"
		status: get_ESC_status(0)
	}

	// Rear right motor information (2)
	CTRL_HardwareModuleStatus {
		x: 590
		y: 588
		width: 63
		height: 63
		smooth: false
		source: "qrc:/images/motor.png"
		status: get_motor_status(mainCore.motor2Power, 0)
	}

	CTRL_ProgressBarWithText {
		x: 538
		y: 478
		width: 20
		height: 140
		orientation: 0
		value: mainCore.motor2Power
		rotation: 135
		text_rotation: -90
		level_warning: motorWarningPower
		level_critical: motorCriticalPower
	}

	CTRL_Parameter {
		x: 460
		y: 366
		width: 100
		value: 0
		title: "Температура"
		postfix: " °C"
		warning_value: escWarningTemperature
		critical_value: escCriticalTemperature
	}
	CTRL_HardwareModuleStatus {
		x: 430
		y: 430
		width: 75
		height: 75
		rotation: 90
		source: "qrc:/images/ESC.png"
		status: get_ESC_status(0)
	}

	// Rear left motor information (3)
	CTRL_HardwareModuleStatus {
		x: 19
		y: 589
		width: 63
		height: 63
		smooth: false
		source: "qrc:/images/motor.png"
		status: get_motor_status(mainCore.motor3Power, 0)
	}

	CTRL_ProgressBarWithText {
		x: 113
		y: 478
		width: 20
		height: 140
		orientation: 0
		value: mainCore.motor3Power
		rotation: -135
		text_rotation: 90
		level_warning: motorWarningPower
		level_critical: motorCriticalPower
	}

	CTRL_Parameter {
		x: 111
		y: 366
		width: 100
		visible: true
		value: 0
		title: "Температура ESC"
		postfix: " °C"
		warning_value: escWarningTemperature
		critical_value: escCriticalTemperature
	}
	CTRL_HardwareModuleStatus {
		x: 166
		y: 430
		width: 75
		height: 75
		rotation: 180
		source: "qrc:/images/ESC.png"
		status: get_ESC_status(0)
	}

	// Front left motor information (4)
	CTRL_HardwareModuleStatus {
		x: 19
		y: 19
		width: 63
		height: 63
		source: "qrc:/images/motor.png"
		status: get_motor_status(mainCore.motor4Power, 0)
	}

	CTRL_ProgressBarWithText {
		x: 113
		y: 53
		width: 20
		height: 140
		orientation: 0
		value: mainCore.motor4Power
		rotation: -45
		text_rotation: 90
		level_warning: motorWarningPower
		level_critical: motorCriticalPower
	}

	CTRL_Parameter {
		x: 111
		y: 251
		width: 100
		value: 0
		postfix: " °C"
		title: "Температура ESC"
		warning_value: escWarningTemperature
		critical_value: escCriticalTemperature
	}

	CTRL_HardwareModuleStatus {
		x: 166
		y: 167
		width: 75
		height: 75
		rotation: -90
		source: "qrc:/images/ESC.png"
		status: get_ESC_status(0)
	}

	// MPU6050
	CTRL_HardwareModuleStatus {
		x: 322
		y: 326
		width: 27
		height: 20
		source: "qrc:/images/sensor.png"
		status: (mainCore.flyCoreStatus & 0x02) == 0
	}

	CTRL_Parameter {
		x: 276
		y: 428
		width: 120
		height: 55
		value: mainCore.hullVibration
		postfix: ""
		title: "Вибрация корпуса"
		warning_value: 50
		critical_value: 70
	}
	CTRL_Parameter {
		x: 276
		y: 511
		width: 120
		height: 55
		title: "Основное питание"
		warning_value: 10.0
		critical_value: 9.5
		value: mainCore.mainVoltage
		postfix: " / 12.6 V"
	}
	CTRL_Parameter {
		x: 151
		y: 613
		width: 120
		height: 55
		title: "Питание передатчика"
		warning_value: 4.5
		critical_value: 4.0
		value: mainCore.wirelessVoltage
		postfix: " / 5.0 V"
	}
	CTRL_Parameter {
		x: 276
		y: 613
		width: 120
		height: 55
		title: "Питание сенсоров"
		warning_value: 3.0
		critical_value: 2.7
		value: mainCore.sensorsVoltage
		postfix: " / 3.3 V"
	}
	CTRL_Parameter {
		x: 401
		y: 613
		width: 120
		height: 55
		title: "Питание камеры"
		warning_value: 4.5
		critical_value: 4.0
		value: mainCore.cameraVoltage
		postfix: " / 5.0 V"
	}
}
