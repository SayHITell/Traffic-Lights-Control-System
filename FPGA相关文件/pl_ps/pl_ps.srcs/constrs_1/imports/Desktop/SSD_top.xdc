#In the following the XDC constraint is matched to the origanal UCF constraint, XDC above, UCF below # Commented

#CLK source 125 MHz
set_property PACKAGE_PIN L16 [get_ports CLK]
set_property IOSTANDARD LVCMOS33 [get_ports CLK]

set_property PACKAGE_PIN P16 [get_ports RSTn]
set_property IOSTANDARD LVCMOS33 [get_ports RSTn]

set_property PACKAGE_PIN T10 [get_ports BTN_RSTn]
set_property IOSTANDARD LVCMOS33 [get_ports BTN_RSTn]

set_property PACKAGE_PIN T14  [get_ports Scan_Sig[0]]
set_property IOSTANDARD LVCMOS33 [get_ports Scan_Sig[0]]
set_property PACKAGE_PIN T15 [get_ports Scan_Sig[1]]
set_property IOSTANDARD LVCMOS33 [get_ports Scan_Sig[1]]
set_property PACKAGE_PIN P14 [get_ports Scan_Sig[2]]
set_property IOSTANDARD LVCMOS33 [get_ports Scan_Sig[2]]
set_property PACKAGE_PIN R14 [get_ports Scan_Sig[3]]
set_property IOSTANDARD LVCMOS33 [get_ports Scan_Sig[3]]
set_property PACKAGE_PIN V12 [get_ports Scan_Sig[4]]
set_property IOSTANDARD LVCMOS33 [get_ports Scan_Sig[4]]
set_property PACKAGE_PIN W16 [get_ports Scan_Sig[5]]
set_property IOSTANDARD LVCMOS33 [get_ports Scan_Sig[5]]
set_property PACKAGE_PIN J15 [get_ports Scan_Sig[6]]
set_property IOSTANDARD LVCMOS33 [get_ports Scan_Sig[6]]
set_property PACKAGE_PIN H15 [get_ports C]
set_property IOSTANDARD LVCMOS33 [get_ports C]

set_property PACKAGE_PIN V20  [get_ports Color_Sig[0]]
set_property IOSTANDARD LVCMOS33 [get_ports Color_Sig[0]]
set_property PACKAGE_PIN U20  [get_ports Color_Sig[1]]
set_property IOSTANDARD LVCMOS33 [get_ports Color_Sig[1]]
set_property PACKAGE_PIN T20  [get_ports Color_Sig[2]]
set_property IOSTANDARD LVCMOS33 [get_ports Color_Sig[2]]

set_property PACKAGE_PIN W19  [get_ports Color_Sub_Sig[0]]
set_property IOSTANDARD LVCMOS33 [get_ports Color_Sub_Sig[0]]
set_property PACKAGE_PIN W18  [get_ports Color_Sub_Sig[1]]
set_property IOSTANDARD LVCMOS33 [get_ports Color_Sub_Sig[1]]