module column_scan_module
(
    CLK, RSTn, C
);
    
     input CLK;
     input RSTn;
     output C;
     
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
     
     reg rColumn_Scan;

     always @ ( posedge CLK or negedge RSTn )
         if( !RSTn )
              rColumn_Scan <= 1'b0;
          else if( Count1 == T2MS )
              case( t )
                
                    2'd0 : rColumn_Scan <= 1'b1;
                     2'd1 : rColumn_Scan <= 1'b0;

                endcase  
                
     /******************************/
     
     assign C = rColumn_Scan;
     
     /******************************/
              

endmodule