module row_scan_module
(
    CLK, RSTn,
     Ten_SMG_Data, One_SMG_Data,
     Scan_Sig
);

    input CLK;
     input RSTn;
     input [6:0]Ten_SMG_Data;
     input [6:0]One_SMG_Data;
     output [6:0]Scan_Sig;
     
     /*****************************/
     
     parameter T2MS = 22'd1_249_999;

     /*****************************/
     
     reg [21:0]Count1;

     always @ ( posedge CLK or negedge RSTn )
         if( !RSTn )
              Count1 <= 22'd0;
          else if( Count1 == T2MS )
              Count1 <= 22'd0;
          else
              Count1 <= Count1 + 1'b1;
    
     /*******************************/

     reg [1:0]t;
     
     always @ ( posedge CLK or negedge RSTn )
         if( !RSTn )
              t <= 2'd0;
          else if( t == 2'd2 )
              t <= 2'd0;
          else if( Count1 == T2MS )
              t <= t + 1'b1;

    /*********************************/

     reg [6:0]rData;
    
    always @ ( posedge CLK or negedge RSTn )
         if( !RSTn )
              rData <= 7'd0;
          else if( Count1 == T2MS )
              case( t )
                
                  2'd0 : rData <= Ten_SMG_Data;
                     2'd1 : rData <= One_SMG_Data; 
            
                endcase
                
    /***********************************/

     assign Scan_Sig = rData;
     
     /***********************************/
              
endmodule