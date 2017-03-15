module SSD_encoder_module
(
    CLK, RSTn,
     Ten_Data, One_Data,
     Ten_SMG_Data, One_SMG_Data
);

     input CLK;
     input RSTn;
     input [3:0]Ten_Data;
     input [3:0]One_Data;
     output [6:0]Ten_SMG_Data;
     output [6:0]One_SMG_Data;
     
     /***************************************/
     
     parameter _0 = 7'b11_1111, _1 = 7'b110, _2 = 7'b101_1011,
               _3 = 7'b100_1111, _4 = 7'b110_0110, _5 = 7'b110_1101,
                  _6 = 7'b111_1101, _7 = 7'b111, _8 = 7'b111_1111,
                  _9 = 7'b110_1111;

     /***************************************/

     reg [6:0]rTen_SMG_Data;

     always @ ( posedge CLK or negedge RSTn )
         if( !RSTn )
              begin
                    rTen_SMG_Data <= 7'b0;
                end
        else 
               case( Ten_Data )

                      4'd0 : rTen_SMG_Data <= _0;
                      4'd1 : rTen_SMG_Data <= _1;
                      4'd2 : rTen_SMG_Data <= _2;
                      4'd3 : rTen_SMG_Data <= _3;
                      4'd4 : rTen_SMG_Data <= _4;
                      4'd5 : rTen_SMG_Data <= _5;
                      4'd6 : rTen_SMG_Data <= _6;
                      4'd7 : rTen_SMG_Data <= _7;
                      4'd8 : rTen_SMG_Data <= _8;
                      4'd9 : rTen_SMG_Data <= _9;
                      
                 endcase
              
     
     /***************************************/
     
     reg [6:0]rOne_SMG_Data;

     always @ ( posedge CLK or negedge RSTn )
        if( !RSTn )
             begin
                    rOne_SMG_Data <= 7'b0;
              end
       else 
             case( One_Data )

                    4'd0 : rOne_SMG_Data <= _0;
                    4'd1 : rOne_SMG_Data <= _1;
                    4'd2 : rOne_SMG_Data <= _2;
                    4'd3 : rOne_SMG_Data <= _3;
                    4'd4 : rOne_SMG_Data <= _4;
                    4'd5 : rOne_SMG_Data <= _5;
                    4'd6 : rOne_SMG_Data <= _6;
                    4'd7 : rOne_SMG_Data <= _7;
                    4'd8 : rOne_SMG_Data <= _8;
                    4'd9 : rOne_SMG_Data <= _9;
                      
              endcase
              
    /***************************************/

     assign Ten_SMG_Data = rTen_SMG_Data;
     assign One_SMG_Data = rOne_SMG_Data;
     
     /***************************************/
              
endmodule