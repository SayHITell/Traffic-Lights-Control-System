	module SSD_top
	(
		CLK, RSTn,
		BTN_RSTn,
		Change_Mode, //ct gyr 123 cc gyr 567
		Number_Data,
		Scan_Sig, C,
		Color_Sig,
		Color_Sub_Sig
	);

		input CLK;
		input RSTn;
		input BTN_RSTn;//行人按钮
		input[6:0] Number_Data;
		input[3:0] Change_Mode;
		output[6:0] Scan_Sig;
		output C;
		output[2:0] Color_Sig;
		output[1:0] Color_Sub_Sig;

		/**************************************/

		wire[3:0] Ten_Data;
		wire[3:0] One_Data;

		/************************************/

		parameter T1S = 29'd124_999_999;//时钟频率125MHZ
		 
		/************************************/

		reg[28:0] Count1;
		always @ ( posedge CLK or negedge RSTn )
			begin
				if( RSTn )
					Count1 <= 29'd0;		
				else if( Count1 == T1S )
					Count1 <= 29'd0;
				else
					Count1 <= Count1 + 1'b1;	
			end
		/***************************************/

		reg[6:0] Counter_Sec=7'd30;
		reg[6:0] RedTimer=7'd10;
		reg[6:0] YellowTimer=7'd5;
		reg[6:0] GreenTimer=7'd30;
		reg[6:0] ChangeTimer=7'd15;
		reg[2:0] c_sig=3'b001;
		reg[1:0] c_s_sig = 2'b10;
		reg flag=1'd0;

		always @ ( posedge CLK  )
			begin
				if( RSTn )             
					begin
						Counter_Sec <= GreenTimer;                        
						c_sig <= 3'b001;
						c_sig <= 2'b10;
						flag <= 1'd0;
					end
				else
					begin
						case(Change_Mode)
						4'd1: GreenTimer <= Number_Data;
						4'd2: YellowTimer <= Number_Data;
						4'd3: RedTimer <= Number_Data;
						4'd4: begin c_sig <= 3'b001; c_s_sig <= 3'b10; Counter_Sec <= GreenTimer; end
						4'd5: begin c_sig <= 3'b010; c_s_sig <= 3'b10; Counter_Sec <= YellowTimer; end
						4'd6: begin c_sig <= 3'b100; c_s_sig <= 3'b01; Counter_Sec <= RedTimer; end
						endcase 
					end
				if(~BTN_RSTn)
					flag <= 1'd1;
				if(flag == 1'd1 && c_sig == 3'b001 && Counter_Sec < ChangeTimer )
					begin
						Counter_Sec <= YellowTimer;
						c_sig <= 3'b010;
					end   
				if(Count1 == T1S)
					begin
						if( Counter_Sec > 8'd0 )
							Counter_Sec <= Counter_Sec - 1'b1;
						else
							begin
								if(c_sig < 3'b100)
									begin
										c_sig <= {c_sig[1:0],c_sig[2]};
										if(c_sig == 3'b010)
											c_s_sig <= 2'b01;
									end
								else
									begin
										flag <= 1'd0;
										c_sig <= 3'b001;
										c_s_sig <= 2'b10;
									end
								case(c_sig)
								3'b001: begin
									Counter_Sec <= YellowTimer;							
									end
								3'b010:begin
									Counter_Sec <= RedTimer;					   
									end
								3'b100: begin
									Counter_Sec <= GreenTimer;						   
									end
								endcase
							end
					end
			end
			
		/****************************************/
		assign Color_Sig = c_sig;
		assign Color_Sub_Sig = c_s_sig;
		 
		number_mod_module mod
		(
			.CLK( CLK ),
			.RSTn( ~RSTn ),
			.Number_Data( Counter_Sec ), // input - form top
			.Ten_Data( Ten_Data ), // output - to encoder
			.One_Data( One_Data )  // output - to encoder
		);
		 
		 /****************************************/

		wire [6:0]Ten_SMG_Data;
		wire [6:0]One_SMG_Data;

		SSD_encoder_module encoder
		(
			.CLK( CLK ),
			.RSTn( ~RSTn ),
			.Ten_Data( Ten_Data ), // input - from mod
			.One_Data( One_Data ), // input - from mod
			.Ten_SMG_Data( Ten_SMG_Data ), // output - to scan
			.One_SMG_Data( One_SMG_Data )  // output - to scan
		);

		/*****************************************/
		 
		SSD_scan_module scan
		(
			.CLK( CLK ),
			.RSTn( ~RSTn ),
			.Ten_SMG_Data( Ten_SMG_Data ), // input - from encoder
			.One_SMG_Data( One_SMG_Data ), // input - from encoder
			.Scan_Sig( Scan_Sig ), // output - to top
			.C( C ) // output - to top
		);

		/******************************************/
		 
	endmodule
