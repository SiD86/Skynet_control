//  ***************************************************************************
/// @file    wireless_protocol.h
/// @author  NeoProg
/// @brief   Wireless protocol
//  ***************************************************************************
#ifndef WIRELESS_PROTOCOL_H_
#define WIRELESS_PROTOCOL_H_

#define uint32_t quint32
#define uint16_t quint16
#define uint8_t	quint8


//
// Frame size - 40
//
#pragma pack (push, 1)
typedef struct {

	uint32_t number;		// Frame number
	uint8_t data[32];		// Frame data
	uint32_t CRC;			// Frame CRC

} wireless_protocol_frame_t;
#pragma pack (pop)


//
// Control data (PC -> CONTROLLER)
//
#pragma pack (push, 1)
typedef struct {

	uint8_t command;
	uint8_t reserved[31];

} wireless_protocol_control_data_t;
#pragma pack (pop)


//
// State data (CONTROLLER -> PC)
//
#pragma pack (push, 1)
typedef struct {

	uint32_t error_status;

	uint16_t wireless_voltage;
	uint16_t periphery_voltage;
	uint16_t battery_bank0_voltage;
	uint16_t battery_bank1_voltage;
	uint16_t power_board_temperature;


	uint8_t reserved[18];

} wireless_protocol_state_data_t;
#pragma pack (pop)


#endif /* WIRELESS_PROTOCOL_H_ */
