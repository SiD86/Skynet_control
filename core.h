#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QQuickItem>
#include <QFile>
#include "joystick.h"
#include "TXRX_PROTOCOL.h"
#include "wirelesscontroller.h"
#include "logcontroller.h"

class Core : public QObject
{
	Q_OBJECT
private: // Read only property list for QML
	Q_PROPERTY(unsigned char mainCoreStatus    READ getMainCoreStatus    NOTIFY updateQML)
	Q_PROPERTY(unsigned char flyCoreStatus     READ getFlyCoreStatus     NOTIFY updateQML)
	Q_PROPERTY(unsigned char flyCoreMode       READ getFlyCoreMode       NOTIFY updateQML)
	Q_PROPERTY(unsigned char motor1Power       READ getMotor1Power       NOTIFY updateQML)
	Q_PROPERTY(unsigned char motor2Power       READ getMotor2Power       NOTIFY updateQML)
	Q_PROPERTY(unsigned char motor3Power       READ getMotor3Power       NOTIFY updateQML)
	Q_PROPERTY(unsigned char motor4Power       READ getMotor4Power       NOTIFY updateQML)
	Q_PROPERTY(double        currentAngleX     READ getCurrentAngleX     NOTIFY updateQML)
	Q_PROPERTY(double        currentAngleY     READ getCurrentAngleY     NOTIFY updateQML)
	Q_PROPERTY(double        currentAngleZ     READ getCurrentAngleZ     NOTIFY updateQML)
	Q_PROPERTY(double        currentGyroX      READ getCurrentGyroX      NOTIFY updateQML)
	Q_PROPERTY(double        currentGyroY      READ getCurrentGyroY      NOTIFY updateQML)
	Q_PROPERTY(double        currentGyroZ      READ getCurrentGyroZ      NOTIFY updateQML)
	Q_PROPERTY(int           currentAlttitude  READ getCurrentAlttitude  NOTIFY updateQML)
	Q_PROPERTY(double		 mainVoltage       READ getMainVoltage       NOTIFY updateQML)
	Q_PROPERTY(double		 wirelessVoltage   READ getWirelessVoltage   NOTIFY updateQML)
	Q_PROPERTY(double		 cameraVoltage     READ getCameraVoltage     NOTIFY updateQML)
	Q_PROPERTY(double		 sensorsVoltage    READ getSensorsVoltage    NOTIFY updateQML)
	Q_PROPERTY(int   		 hullVibration     READ getHullVibration     NOTIFY updateQML)

	Q_PROPERTY(short         destAngleX        READ getDestAngleX        NOTIFY updateQML)
	Q_PROPERTY(short         destAngleY        READ getDestAngleY        NOTIFY updateQML)
	Q_PROPERTY(short         destAngleZ        READ getDestAngleZ        NOTIFY updateQML)
	Q_PROPERTY(unsigned char thrust            READ getThrust            NOTIFY updateQML)

	Q_PROPERTY(double        PX                WRITE setPX                              )
	Q_PROPERTY(double        IX                WRITE setIX                              )
	Q_PROPERTY(double        DX                WRITE setDX                              )
	Q_PROPERTY(double        PY                WRITE setPY                              )
	Q_PROPERTY(double        IY                WRITE setIY                              )
	Q_PROPERTY(double        DY                WRITE setDY                              )
	Q_PROPERTY(double        PZ                WRITE setPZ                              )
	Q_PROPERTY(double        IZ                WRITE setIZ                              )
	Q_PROPERTY(double        DZ                WRITE setDZ                              )


	uint8_t getMainCoreStatus()   { return m_stateData.main_core_status;    }
	uint8_t getFlyCoreStatus()    { return m_stateData.fly_core_status;     }
	uint8_t getFlyCoreMode()      { return m_stateData.fly_core_mode;       }
	uint8_t getMotor1Power()      { return m_stateData.motors_power[0];     }
	uint8_t getMotor2Power()      { return m_stateData.motors_power[1];     }
	uint8_t getMotor3Power()	  { return m_stateData.motors_power[2];     }
	uint8_t getMotor4Power()      { return m_stateData.motors_power[3];     }
	double  getCurrentAngleX()    { return m_stateData.XYZ[0] / 100.0;      }
	double  getCurrentAngleY()    { return m_stateData.XYZ[1] / 100.0;      }
	double  getCurrentAngleZ()    { return m_stateData.XYZ[2] / 100.0;      }
	double  getCurrentGyroX()     { return m_stateData.gyro_XYZ[0] / 100.0; }
	double  getCurrentGyroY()     { return m_stateData.gyro_XYZ[1] / 100.0; }
	double  getCurrentGyroZ()     { return m_stateData.gyro_XYZ[2] / 100.0; }
	int32_t getCurrentAlttitude() { return m_stateData.alttitude;               }
	double  getMainVoltage()      { return m_stateData.main_voltage / 10.0;     }
	double  getWirelessVoltage()  { return m_stateData.wireless_voltage / 10.0; }
	double  getCameraVoltage()    { return m_stateData.camera_voltage / 10.0;   }
	double  getSensorsVoltage()   { return m_stateData.sensors_voltage / 10.0;  }
	int		getHullVibration()    { return m_stateData.hull_vibration;      }

	int16_t getDestAngleX()       { return m_controlData.XYZ[0];            }
	int16_t getDestAngleY()       { return m_controlData.XYZ[1];            }
	int16_t getDestAngleZ()       { return m_controlData.XYZ[2];            }
	uint8_t getThrust()           { return m_controlData.thrust;            }

	void setPX(double P)          { m_PID[0][0] = P * 100;                  }
	void setIX(double I)          { m_PID[0][1] = I * 100;                  }
	void setDX(double D)          { m_PID[0][2] = D * 100;                  }
	void setPY(double P)          { m_PID[1][0] = P * 100;                  }
	void setIY(double I)          { m_PID[1][1] = I * 100;                  }
	void setDY(double D)          { m_PID[1][2] = D * 100;                  }
	void setPZ(double P)          { m_PID[2][0] = P * 100;                  }
	void setIZ(double I)          { m_PID[2][1] = I * 100;                  }
	void setDZ(double D)          { m_PID[2][2] = D * 100;                  }

private:
	LogController* m_logController;
    Joystick* m_joystick;

	TXRX::control_data_t m_controlData;
	TXRX::state_data_t m_stateData;

	QQuickItem* m_debugWidget;

	uint16_t m_PID[3][3];

signals: // To QML interface
	void wirelessControllerCountersUpdated(int rx, int tx, int error);
	void updateQML();

public slots:
	QVariant getVersion();
	void constructControlPacket();				// From WirelessController
	void statePacketProcess();					// From WirelessController

public:
	explicit Core();
	~Core();
	void initialize(QQuickItem* rootObject);
};
#endif // MAINWINDOW_H
