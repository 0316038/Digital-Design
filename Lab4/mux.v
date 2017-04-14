`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:33:49 11/24/2015 
// Design Name: 
// Module Name:    mux 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mux(
		input clk,rst,
		input[5:0]sel,
		input [0:2047]temp,
		output reg [7:0]in0,in1,in2,in3,in4,in5,in6,in7
    );
	 
	 always @(posedge clk)begin
		case(sel)
			5'd0: begin
						in0=temp[0:7];
						in1=temp[8:15];
						in2=temp[16:23];
						in3=temp[24:31];
						in4=temp[32:39];
						in5=temp[40:47];
						in6=temp[48:55];
						in7=temp[56:63];
					end
			5'd1: begin
					   in0=temp[64:71];
						in1=temp[72:79];
						in2=temp[80:87];
						in3=temp[88:95];
						in4=temp[96:103];
						in5=temp[104:111];
						in6=temp[112:119];
						in7=temp[120:127];
					end
			5'd2: begin
						in0=temp[128:135];
						in1=temp[136:143];
						in2=temp[144:151];
						in3=temp[152:159];
						in4=temp[160:167];
						in5=temp[168:175];
						in6=temp[176:183];
						in7=temp[184:191];
					end
			5'd3: begin
						in0=temp[192:199];
						in1=temp[200:207];
						in2=temp[208:215];
						in3=temp[216:223];
						in4=temp[224:231];
						in5=temp[232:239];
						in6=temp[240:247];
						in7=temp[248:255];
					end
			5'd4: begin
						in0=temp[256:263];
						in1=temp[264:271];
						in2=temp[272:279];
						in3=temp[280:287];
						in4=temp[288:295];
						in5=temp[296:303];
						in6=temp[304:311];
						in7=temp[312:319];
					end
			5'd5: begin
						in0=temp[320:327];
						in1=temp[328:335];
						in2=temp[336:343];
						in3=temp[344:351];
						in4=temp[352:359];
						in5=temp[360:367];
						in6=temp[368:375];
						in7=temp[376:383];
					end
			5'd6: begin
						in0=temp[384:391];
						in1=temp[392:399];
						in2=temp[400:407];
						in3=temp[408:415];
						in4=temp[416:423];
						in5=temp[424:431];
						in6=temp[432:439];
						in7=temp[440:447];
					end
			5'd7: begin
						in0=temp[448:455];
						in1=temp[456:463];
						in2=temp[464:471];
						in3=temp[472:479];
						in4=temp[480:487];
						in5=temp[488:495];
						in6=temp[496:503];
						in7=temp[504:511];
					end
			5'd8: begin
						in0=temp[512:519];
						in1=temp[520:527];
						in2=temp[528:535];
						in3=temp[536:543];
						in4=temp[544:551];
						in5=temp[552:559];
						in6=temp[560:567];
						in7=temp[568:575];
					end
			5'd9: begin
						in0=temp[576:583];
						in1=temp[584:591];
						in2=temp[592:599];
						in3=temp[600:607];
						in4=temp[608:615];
						in5=temp[616:623];
						in6=temp[624:631];
						in7=temp[632:639];
					end
			5'd10: begin
						in0=temp[640:647];
						in1=temp[648:655];
						in2=temp[656:663];
						in3=temp[664:671];
						in4=temp[672:679];
						in5=temp[680:687];
						in6=temp[688:695];
						in7=temp[696:703];
					end
			5'd11: begin
						in0=temp[704:711];
						in1=temp[712:719];
						in2=temp[720:727];
						in3=temp[728:735];
						in4=temp[736:743];
						in5=temp[744:751];
						in6=temp[752:759];
						in7=temp[760:767];
					end
			5'd12: begin
						in0=temp[768:775];
						in1=temp[776:783];
						in2=temp[784:791];
						in3=temp[792:799];
						in4=temp[800:807];
						in5=temp[808:815];
						in6=temp[816:823];
						in7=temp[824:831];
					end
			5'd13: begin
						in0=temp[832:839];
						in1=temp[840:847];
						in2=temp[848:855];
						in3=temp[856:863];
						in4=temp[864:871];
						in5=temp[872:879];
						in6=temp[880:887];
						in7=temp[888:895];
					end
			5'd14: begin
						in0=temp[896:903];
						in1=temp[904:911];
						in2=temp[912:919];
						in3=temp[920:927];
						in4=temp[928:935];
						in5=temp[936:943];
						in6=temp[944:951];
						in7=temp[952:959];
					end
			5'd15: begin
						in0=temp[960:967];
						in1=temp[968:975];
						in2=temp[976:983];
						in3=temp[984:991];
						in4=temp[992:999];
						in5=temp[1000:1007];
						in6=temp[1008:1015];
						in7=temp[1016:1023];
					end
			5'd16: begin
						in0=temp[1024:1031];
						in1=temp[1032:1039];
						in2=temp[1040:1047];
						in3=temp[1048:1055];
						in4=temp[1056:1063];
						in5=temp[1064:1071];
						in6=temp[1072:1079];
						in7=temp[1080:1087];
					end
			5'd17: begin
						in0=temp[1088:1095];
						in1=temp[1096:1103];
						in2=temp[1104:1111];
						in3=temp[1112:1119];
						in4=temp[1120:1127];
						in5=temp[1128:1135];
						in6=temp[1136:1143];
						in7=temp[1144:1151];
					end
			5'd18: begin
						in0=temp[1152:1159];
						in1=temp[1160:1167];
						in2=temp[1168:1175];
						in3=temp[1176:1183];
						in4=temp[1184:1191];
						in5=temp[1192:1199];
						in6=temp[1200:1207];
						in7=temp[1208:1215];
					end
			5'd19: begin
						in0=temp[1216:1223];
						in1=temp[1224:1231];
						in2=temp[1232:1239];
						in3=temp[1240:1247];
						in4=temp[1248:1255];
						in5=temp[1256:1263];
						in6=temp[1264:1271];
						in7=temp[1272:1279];
					end
			5'd20: begin
						in0=temp[1280:1287];
						in1=temp[1288:1295];
						in2=temp[1296:1303];
						in3=temp[1304:1311];
						in4=temp[1312:1319];
						in5=temp[1320:1327];
						in6=temp[1328:1335];
						in7=temp[1336:1343];
					end
			5'd21: begin
						in0=temp[1344:1351];
						in1=temp[1352:1359];
						in2=temp[1360:1367];
						in3=temp[1368:1375];
						in4=temp[1376:1383];
						in5=temp[1384:1391];
						in6=temp[1392:1399];
						in7=temp[1400:1407];
					end
			5'd22: begin
						in0=temp[1408:1415];
						in1=temp[1416:1423];
						in2=temp[1424:1431];
						in3=temp[1432:1439];
						in4=temp[1440:1447];
						in5=temp[1448:1455];
						in6=temp[1456:1463];
						in7=temp[1464:1471];
					end
			5'd23: begin
						in0=temp[1472:1479];
						in1=temp[1480:1487];
						in2=temp[1488:1495];
						in3=temp[1496:1503];
						in4=temp[1504:1511];
						in5=temp[1512:1519];
						in6=temp[1520:1527];
						in7=temp[1528:1535];
					end
			5'd24: begin
						in0=temp[1536:1543];
						in1=temp[1544:1551];
						in2=temp[1552:1559];
						in3=temp[1560:1567];
						in4=temp[1568:1575];
						in5=temp[1576:1583];
						in6=temp[1584:1591];
						in7=temp[1592:1599];
					end
			5'd25: begin
						in0=temp[1600:1607];
						in1=temp[1608:1615];
						in2=temp[1616:1623];
						in3=temp[1624:1631];
						in4=temp[1632:1639];
						in5=temp[1640:1647];
						in6=temp[1648:1655];
						in7=temp[1656:1663];
					end
			5'd26: begin
						in0=temp[1664:1671];
						in1=temp[1672:1679];
						in2=temp[1680:1687];
						in3=temp[1688:1695];
						in4=temp[1696:1703];
						in5=temp[1704:1711];
						in6=temp[1712:1719];
						in7=temp[1720:1727];
					end
			5'd27: begin
						in0=temp[1728:1735];
						in1=temp[1736:1743];
						in2=temp[1744:1751];
						in3=temp[1752:1759];
						in4=temp[1760:1767];
						in5=temp[1768:1775];
						in6=temp[1776:1783];
						in7=temp[1784:1791];
					end
			5'd28: begin
						in0=temp[1792:1799];
						in1=temp[1800:1807];
						in2=temp[1808:1815];
						in3=temp[1816:1823];
						in4=temp[1824:1831];
						in5=temp[1832:1839];
						in6=temp[1840:1847];
						in7=temp[1848:1855];
					end
			5'd29: begin
						in0=temp[1856:1863];
						in1=temp[1864:1871];
						in2=temp[1872:1879];
						in3=temp[1880:1887];
						in4=temp[1888:1895];
						in5=temp[1896:1903];
						in6=temp[1904:1911];
						in7=temp[1912:1919];
					end
			5'd30: begin  
						in0=temp[1920:1927];
						in1=temp[1928:1935];
						in2=temp[1936:1943];
						in3=temp[1944:1951];
						in4=temp[1952:1959];
						in5=temp[1960:1967];
						in6=temp[1968:1975];
						in7=temp[1976:1983];
					end
			5'd31: begin
						in0=temp[1984:1991];
						in1=temp[1992:1999];
						in2=temp[2000:2007];
						in3=temp[2008:2015];
						in4=temp[2016:2023];
						in5=temp[2024:2031];
						in6=temp[2032:2039];
						in7=temp[2040:2047];
					end
		endcase
	 end


endmodule
