module SSD_scan_module
(
    CLK, RSTn,
     Ten_SMG_Data, One_SMG_Data,
     Scan_Sig, C
);

    input CLK;
     input RSTn;
     input [6:0]Ten_SMG_Data;
     input [6:0]One_SMG_Data;
     output [6:0]Scan_Sig;
     output C;

     /*****************************/

     row_scan_module row_scan
     (
         .CLK( CLK ),
          .RSTn( RSTn ),
          .Ten_SMG_Data( Ten_SMG_Data ), // input - from top
          .One_SMG_Data( One_SMG_Data ), // input - from top
          .Scan_Sig( Scan_Sig )  // output - to top
     );

     column_scan_module col_scan
     (
         .CLK( CLK ),
          .RSTn( RSTn ),
          .C( C ) // output - to top
     );

     /********************************/

endmodule