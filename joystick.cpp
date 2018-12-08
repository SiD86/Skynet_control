#include <QTimer>
#include <QDebug>
#include <QFile>
#include <QTimer>
#include <QDebug>
#include "joystick.h"
#define UPDATE_STATE_INTERVAL				(200)
#define CONSTRAIN(VALUE, MIN, MAX)			( (VALUE) < (MIN) ? (MIN) : ( (VALUE) > (MAX) ? (MAX) : (VALUE)) )

//
// PUBLIC
//
Joystick::Joystick(QObject* parent) : QObject(parent) {

    memset(&m_state, 0, sizeof(m_state));

	// Initialize SDL
	SDL_SetHint(SDL_HINT_JOYSTICK_ALLOW_BACKGROUND_EVENTS, "1");
	SDL_Init(SDL_INIT_JOYSTICK);
	m_joystick = SDL_JoystickOpen(0);

	// Setup loop
	if (m_joystick != nullptr) {
		QTimer* timer = new QTimer(this);
		connect(timer, SIGNAL( timeout() ), SLOT( update_joystick_state() ));
		timer->setInterval(70);
		timer->start();
	}

	m_is_available = (m_joystick != nullptr);
}

Joystick::~Joystick() {
	SDL_JoystickClose(m_joystick);
	SDL_Quit();
}

bool Joystick::is_available() {
	return m_is_available;
}

JOYSTICK_STATE Joystick::get_state() {
	return m_state;
}

void Joystick::analog_sticks_handler() {

	int x = SDL_JoystickGetAxis(m_joystick, 0);
	int y = SDL_JoystickGetAxis(m_joystick, 1);
	int w = SDL_JoystickGetAxis(m_joystick, 4);

	// Process axis X
	int value = (x + 32768) * 60 / 65535 - 30;
	m_state.XYZ[0] = CONSTRAIN(value, -30, 30);

	// Process axis Y
	value = (y + 32768) * 60 / 65535 - 30;
	m_state.XYZ[1] = -CONSTRAIN(value, -30, 30);

	// Process axis W (thrust)
	value = -w / 32000;
	m_state.thrust += value;
	m_state.thrust = CONSTRAIN(m_state.thrust, 0, 70);
}

void Joystick::button_press_handler(int button, bool is_press) {

	if (is_press == true)
		m_state.button |= (1 << button);
	else
		m_state.button &= ~(1 << button);
}

void Joystick::hat_motion_handler() {

}


//
// SLOTS
//
void Joystick::update_joystick_state() {

	SDL_Event event;
	while (SDL_PollEvent(&event)) {

		switch(event.type) {

		case SDL_JOYBUTTONDOWN:
			button_press_handler(event.jbutton.button, true);
			break;

		case SDL_JOYHATMOTION:
			if (event.jhat.value == 2)
				m_state.XYZ[2] = -10;
			else if (event.jhat.value == 8)
				m_state.XYZ[2] = 10;
			else
				m_state.XYZ[2] = 0;
			break;

		case SDL_JOYBUTTONUP:
			button_press_handler(event.jbutton.button, false);
			break;

		case SDL_QUIT:
		case SDL_JOYDEVICEREMOVED:
			qDebug() << "SDL_JOYDEVICEREMOVED";
			m_is_available = false;
			break;
		}
	}

	SDL_JoystickUpdate();
	analog_sticks_handler();
}
