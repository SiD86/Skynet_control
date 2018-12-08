#ifndef JOYSTICK_H
#define JOYSTICK_H

#include <QObject>
#include <SDL.h>

#define JOYSTICK_BUTTON_1			(1 << 0)
#define JOYSTICK_BUTTON_2			(1 << 1)
#define JOYSTICK_BUTTON_3			(1 << 2)
#define JOYSTICK_BUTTON_4			(1 << 3)
#define JOYSTICK_BUTTON_5			(1 << 4)
#define JOYSTICK_BUTTON_6			(1 << 5)
#define JOYSTICK_BUTTON_7			(1 << 6)
#define JOYSTICK_BUTTON_8			(1 << 7)
#define JOYSTICK_BUTTON_9			(1 << 8)
#define JOYSTICK_BUTTON_10			(1 << 9)
#define JOYSTICK_BUTTON_11			(1 << 10)
#define JOYSTICK_BUTTON_12			(1 << 11)

struct JOYSTICK_STATE {
    qint8 thrust;
    qint16 XYZ[3];
    qint32 button;
};

class Joystick : public QObject
{
	Q_OBJECT

private:
	SDL_Joystick* m_joystick;

    bool m_is_available;
    JOYSTICK_STATE m_state;

public slots:
	void update_joystick_state();

protected:
	void analog_sticks_handler();
	void button_press_handler(int button, bool is_press);
	void hat_motion_handler();

public:
	explicit Joystick(QObject* parent);
	~Joystick();

	bool is_available();
	JOYSTICK_STATE get_state();
};

#endif // JOYSTICK_H
