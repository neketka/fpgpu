//Copyright (C)2014-2024 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.10.01 (64-bit)
//Part Number: GW2AR-LV18QN88C8/I7
//Device: GW2AR-18
//Device Version: C
//Created Time: Sun Sep  1 13:29:29 2024

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	fp_comp your_instance_name(
		.clk(clk), //input clk
		.data_a(data_a), //input [31:0] data_a
		.data_b(data_b), //input [31:0] data_b
		.agb(agb), //output agb
		.alb(alb), //output alb
		.rstn(rstn) //input rstn
	);

//--------Copy end-------------------
