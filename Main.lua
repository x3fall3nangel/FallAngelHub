do local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=getfenv or function()return _ENV;end;local v9=setmetatable;local v10=pcall;local v11=select;local v12=unpack or table.unpack;local v13=tonumber;local function v14(v15,v16)local v17=1;local v18;v15=v4(v3(v15,5),"..",function(v29)if (v1(v29,2)==79) then local v60=0;while true do if (v60==0) then v18=v0(v3(v29,1,1));return "";end end else local v61=v2(v0(v29,16));if v18 then local v75=0;local v76;while true do if (v75==0) then v76=v5(v61,v18);v18=nil;v75=1;end if (1==v75) then return v76;end end else return v61;end end end);local function v19(v30,v31,v32)if v32 then local v62=(v30/(2^(v31-(221 -(13 + 207)))))%((4 -2)^(((v32-(1 + 0)) -(v31-((1 -0) + 0))) + 1 + 0));return v62-(v62%(1453 -(1297 + 155)));else local v63=(5 -3)^(v31-((2 -1) + 0));return (((v30%(v63 + v63))>=v63) and ((1 -0) + 0)) or (1979 -(430 + 1549));end end local function v20()local v37=v1(v15,v17,v17);v17=v17 + 1;return v37;end local function v21()local v38,v39=v1(v15,v17,v17 + (5 -3));v17=v17 + (1538 -(910 + 626));return (v39 * (86 + 170)) + v38;end local function v22()local v40,v41,v42,v43=v1(v15,v17,v17 + 2 + 1);v17=v17 + (9 -5);return (v43 * (2915720 + 13861496)) + (v42 * 65536) + (v41 * (726 -470)) + v40;end local function v23()local v44=v22();local v45=v22();return (( -(6 -4) * v19(v45,(336 -(18 + 241)) -45)) + ((5 -2) -2)) * ((2 -(0 + 0))^(v19(v45,21,(2013 -(301 + 26)) -(769 + 886)) -(880 + 143))) * ((((v19(v45,1,20) * ((1 + 1)^(806 -(740 + (73 -39))))) + v44)/((2 + 0)^(11 + 41))) + ((633 -(196 + 435)) -1));end local function v24(v33)local v46;if  not v33 then local v64=0 + 0;while true do if (v64==(0 + (0 -0))) then v33=v22();if (v33==(0 + 0)) then return "";end break;end end end v46=v3(v15,v17,(v17 + v33) -(718 -(220 + 497)));v17=v17 + v33;local v47={};for v58=1, #v46 do v47[v58]=v2(v1(v3(v46,v58,v58)));end return v6(v47);end local v25=v22;local function v26(...)return {...},v11("#",...);end local function v27()local v48=1131 -(280 + 851);local v49;local v50;local v51;local v52;local v53;local v54;while true do if ((1532 -(784 + 747))~=v48) then else local v71=0 + 0;while true do if (2~=v71) then else v48=8 -6;break;end if (v71==1) then for v78=1,v53 do local v79=562 -(332 + 230);local v80;local v81;local v82;local v83;while true do if ((1 + 0)==v79) then v82=nil;v83=nil;v79=2;end if (v79==(1926 -(647 + 1277))) then while true do if (v80==(2 -1)) then v83=nil;while true do if (v81==(0 -0)) then local v119=0;while true do if (v119==(0 -0)) then v82=v20();v83=nil;v119=1;end if (v119~=(792 -(324 + 467))) then else v81=1;break;end end end if ((1 + 0)~=v81) then else if (v82==1) then v83=v20()~=(0 -0);elseif (v82==2) then v83=v23();elseif (v82==3) then v83=v24();end v54[v78]=v83;break;end end break;end if ((0 + 0)==v80) then local v111=1510 -(614 + 896);while true do if (v111==(3 -2)) then v80=1 -0;break;end if (v111~=0) then else v81=0;v82=nil;v111=3 -2;end end end end break;end if (v79==0) then v80=1557 -(1249 + 308);v81=nil;v79=1;end end end v52[1132 -(172 + 957)]=v20();v71=1779 -(568 + 1209);end if ((0 + 0)~=v71) then else v53=v22();v54={};v71=1;end end end if (v48~=(1173 -(914 + 257))) then else local v72=911 -(552 + 359);while true do if (v72==(1 + 0)) then for v84=1,v22() do v51[v84]=v22();end return v52;end if (v72~=0) then else for v86=1,v22() do local v87=0 -0;local v88;local v89;while true do if (v87~=(3 -2)) then else while true do if (v88~=(0 -0)) then else v89=v20();if (v19(v89,1,1202 -(522 + 679))==(1862 -(1280 + 582))) then local v113=0;local v114;local v115;local v116;local v117;local v118;while true do if (v113~=(0 -0)) then else v114=0;v115=nil;v113=3 -2;end if (v113~=(1169 -(1017 + 151))) then else v116=nil;v117=nil;v113=2;end if (v113==(1600 -(215 + 1383))) then v118=nil;while true do if (v114==(1143 -(889 + 253))) then v117=nil;v118=nil;v114=103 -(81 + 20);end if (2==v114) then while true do if (v115==(888 -(128 + 758))) then local v127=1635 -(158 + 1477);local v128;while true do if (v127==0) then v128=0 -0;while true do if ((1 -0)==v128) then v115=3;break;end if (v128~=0) then else if (v19(v117,1,1)==(1 + 0)) then v118[2]=v54[v118[2]];end if (v19(v117,45 -(4 + 39),2)==1) then v118[3]=v54[v118[2 + 1]];end v128=1;end end break;end end end if (v115==(2 + 1)) then if (v19(v117,3,946 -(414 + 529))==1) then v118[2 + 2]=v54[v118[4]];end v49[v86]=v118;break;end if ((151 -(132 + 18))==v115) then local v130=0;while true do if ((1680 -(65 + 1614))~=v130) then else v115=3 -1;break;end if (v130~=0) then else v118={v21(),v21(),nil,nil};if (v116==0) then local v189=0 -0;local v190;local v191;local v192;while true do if (v189~=(1595 -(229 + 1366))) then else v190=0 -0;v191=nil;v189=1 + 0;end if (v189~=1) then else v192=nil;while true do if (v190==1) then while true do if (v191~=0) then else v192=0 + 0;while true do if (v192~=0) then else v118[5 -2]=v21();v118[4]=v21();break;end end break;end end break;end if (0==v190) then local v229=0 + 0;while true do if (v229~=1) then else v190=1 + 0;break;end if (v229==(323 -(218 + 105))) then v191=1445 -(1370 + 75);v192=nil;v229=1161 -(644 + 516);end end end end break;end end elseif (v116==(2 -1)) then v118[3]=v22();elseif (v116==(3 -1)) then v118[3]=v22() -((4 -2)^(22 -6));elseif (v116==(3 + 0)) then local v230=0;local v231;local v232;while true do if (v230==0) then local v234=0 -0;while true do if (v234==(2 -1)) then v230=1373 -(1201 + 171);break;end if (v234==0) then v231=1916 -(1067 + 849);v232=nil;v234=1;end end end if (v230==(1 + 0)) then while true do if (v231==(1453 -(815 + 638))) then v232=0 + 0;while true do if (v232==(0 -0)) then v118[3 + 0]=v22() -((2 + 0)^16);v118[418 -(133 + 281)]=v21();break;end end break;end end break;end end end v130=1 -0;end end end if (v115==(1550 -(401 + 1149))) then local v131=0;while true do if (v131==(1325 -(1238 + 86))) then v115=1;break;end if ((1976 -(505 + 1471))==v131) then v116=v19(v89,1 + 1,3 + 0);v117=v19(v89,4,6);v131=1 -0;end end end end break;end if (v114==0) then v115=1817 -(1284 + 533);v116=nil;v114=1;end end break;end end end break;end end break;end if ((0 + 0)==v87) then v88=0 -0;v89=nil;v87=1;end end end for v90=1 + 0,v22() do v50[v90-(1 + 0)]=v27();end v72=65 -(12 + 52);end end end if (v48==0) then local v73=0 -0;local v74;while true do if (v73==(0 + 0)) then v74=0;while true do if (v74==0) then local v107=0;while true do if (v107==1) then v74=1;break;end if (v107==(0 + 0)) then v49={};v50={};v107=1;end end end if (v74~=2) then else v48=1;break;end if ((1 -0)==v74) then local v108=0;while true do if (v108==0) then v51={};v52={v49,v50,nil,v51};v108=2 -1;end if (v108==(1 -0)) then v74=4 -2;break;end end end end break;end end end end end local function v28(v34,v35,v36)local v55=v34[1];local v56=v34[2];local v57=v34[3];return function(...)local v65=0;local v66;local v67;local v68;local v69;local v70;while true do if (v65==1) then v68={...};v69=v11("#",...) -1;v65=2;end if (v65==2) then v70=nil;function v70()local v92=v55;local v93=Const;local v94=v56;local v95=v57;local v96=v26;local v97={};local v98={};local v99={};for v104=0 + 0,v69 do if ((2262<3957) and (v104>=v95)) then v97[v104-v95]=v68[v104 + ((1 + 1) -1)];else v99[v104]=v68[v104 + (990 -(294 + 695))];end end local v100=(v69-v95) + (3 -2);local v101;local v102;while true do local v105=0 + 0;local v106;while true do if (((4874 -(413 + 43))<(223 + 3549 + 1004)) and (v105==(106 -(12 + 94)))) then v106=0 + 0;while true do if (((4554 -(118 + 417))>(9476 -7096)) and (v106==1)) then if (((4795 -(2411 -1241))<(1973 + (4322 -2370))) and (v102<=(44 -32))) then if ((v102<=(12 -7)) or ((1523 + 1498)==(1613 + 1562))) then if (((4767 -(24 + 430))>(1395 + 1180)) and (v102<=(1324 -(248 + 1074)))) then if ((v102<=(1105 -(668 + 437))) or ((3622 + 395)<(9640 -(2541 + 3806)))) then if ((v99[v101[5 -3]]==v101[944 -(195 + 745)]) or ((2467 -(393 + 257))>(5610 -3725))) then v66=v66 + (2 -1);else v66=v101[3 + 0];end elseif (((48 + 238)==(1321 -(987 + 48))) and (v102>(702 -(415 + 286)))) then local v132=(3404 -(45 + 1404)) -(1886 + 69);local v133;local v134;while true do if (((291 -(216 + 74))==v132) or ((2002 -(1368 + 277))>=(16173 -11869))) then while true do if (((1581 + 2998)>=(4416 -(939 + (1256 -778)))) and (v133==(0 -0))) then v134=v101[9 -7];v99[v134]=v99[v134](v12(v99,v134 + (1762 -(1411 + 350)),v67));break;end end break;end if ((v132==(1805 -(1781 + 24))) or ((643 + 194)>=(3371 -(39 + 278)))) then v133=0 + 0;v134=nil;v132=1 + 0 + 0;end end else local v135=0 -(1085 -(998 + 87));local v136;local v137;local v138;local v139;while true do if (((7049 -4534)>=(480 -371)) and (v135==(539 -(86 + 452)))) then v138=nil;v139=nil;v135=26 -(22 + 2);end if ((1749>=1566) and (v135==(2 -0))) then while true do if (((3706 -(251 + 738))>(1547 + 1146)) and (v136==(1546 -(1335 + 210)))) then v139=nil;while true do if (((2136 -(1776 + 124))<(7653 -5851)) and (v137==(772 -(124 + 647)))) then v99[v138 + (1 -0)]=v139;v99[v138]=v139[v101[4 -0]];break;end if (((511 + (3673 -1983))==((10578 -6483) -((1858 -1366) + 1402))) and (v137==(688 -(576 + 112)))) then local v224=0 -0;while true do if ((v224==(0 + 0)) or ((782 + 165)==(14423 -10080))) then v138=v101[1265 -(1022 + 241)];v139=v99[v101[476 -(186 + 287)]];v224=1 -0;end if (((2888 -(117 + 107))>=(2394 -(452 + 167))) and (v224==(1 + (0 -0)))) then v137=642 -((927 -530) + 244);break;end end end end break;end if (((7293 -3766)<(1717 + 2623)) and ((0 -0)==v136)) then local v195=0 + 0;while true do if (((1592 -(147 + 186))<=(1846 + 154)) and (v195==(0 + 0))) then v137=(821 -(473 + 348)) + 0;v138=nil;v195=1369 -(81 + 1287);end if ((v195==((1 + 1) -1)) or ((7130 -4373)>=(2270 + 670 + 1196))) then v136=1 + 0;break;end end end end break;end if ((v135==(0 -0)) or ((5670 -(148 + 834))>(18982 -14147))) then v136=0 -0;v137=nil;v135=1 + 0;end end end elseif ((v102<=(1 + 2)) or (480<=(1925 -(1105 + 402)))) then v99[v101[1 + 1]]();elseif ((v102>(14 -10)) or ((4445 -(4729 -(1659 + 123)))<=(2458 -(918 + 463)))) then v99[v101[5 -(607 -(74 + 530))]]=v99[v101[1159 -(648 + 508)]];else local v141=0 + 0;local v142;local v143;local v144;while true do if ((v141==((1450 -(438 + 1012)) -0)) or (((2453 -(258 + 285)) -682)<(374 -214))) then v142=0 -0;v143=nil;v141=(2 -1) -0;end if (((1364 + 1613)<=(2117 + 2354)) and (v141==(3 -(4 -2)))) then v144=nil;while true do if (((6959 -4677)==((1848 + 1825) -1391)) and ((1301 -(413 + 887))==v142)) then while true do if (((2577 + 296)>(5319 -3074)) and (v143==(0 + 0))) then v144=v101[2 + 0];do return v12(v99,v144,v144 + v101[4 -1]);end break;end end break;end if (((3206 -(297 + 1085))<(5000 -(164 + 319))) and (v142==((994 -(51 + 943)) + 0))) then v143=1751 -(542 + 1209);v144=nil;v142=202 -(174 + 27);end end break;end end end elseif ((v102<=(583 -(225 + 350))) or ((2890 -(415 + 710 + 275))>=(2178 + 2601))) then if (((8153 -4073)>=(9470 -5534)) and (v102<=(23 -17))) then local v122=487 -(73 + 46 + 368);local v123;local v124;local v125;while true do if (((3786 -(490 + 37))==(2698 + 561)) and (((2455 -(18 + 517)) -(79 + 1840))==v122)) then v125=nil;while true do if (((3707 -1850)>(273 -111)) and (v123==(652 -(487 + 164)))) then for v193=v124 + 1 + (0 -0),v101[4 + 0] do v125=v125   .. v99[v193];end v99[v101[1 + 1]]=v125;break;end if (((0 + 0 + 0)==v123) or ((1215 + 566 + 1362)>(12608 -8830))) then local v185=0 + 0;while true do if (((2 + 0)<((9043 -3387) -((1304 -801) + 973))) and (v185==(1 + (776 -(168 + 608))))) then v123=2 -1;break;end if ((v185==(923 -(815 + 108))) or ((806 + 317)>=(2206 -(226 + 198)))) then v124=v101[1957 -(875 + 1079)];v125=v99[v124];v185=1 + 0;end end end end break;end if (((782 + 3716)>=(580 + 2583)) and ((0 + 0)==v122)) then v123=(0 -0) -0;v124=nil;v122=1351 -(179 + 1171);end end elseif (((7482 -2755)>=(3402 + 546)) and (v102==(459 -(38 + 414)))) then local v145=0 + 0;local v146;while true do if (((7683 -5165)>(1996 -(1185 + 307))) and ((1545 -(1525 + 20))==v145)) then v146=v101[(11 -7) -2];v99[v146](v12(v99,v146 + (1048 -(306 + (3437 -2696))),v101[6 -3]));break;end end else local v147=0 + 0;local v148;while true do if (((5768 -(344 + (1157 -436)))>(2370 + 614)) and (v147==(1484 -(1409 + 75)))) then v148=v101[438 -((1529 -(635 + 794)) + 336)];v99[v148]=v99[v148](v99[v148 + (1667 -(232 + 1434))]);break;end end end elseif ((v102<=(787 -(333 + 39 + 405))) or ((233 + 4247)<=(1969 -(86 + 4)))) then if ((v102==((3 + 17) -11)) or ((5799 -2500)==(3770 -(622 + 1263)))) then if (((3395 + 543)>(1871 -(868 + 666))) and (v99[v101[1 + 1]]~=v101[13 -9])) then v66=v66 + (1306 -(1147 + 158));else v66=v101[892 -(616 + 273)];end else local v149=0 + 0;local v150;local v151;while true do if (((1718 -1088)<(4304 -((1525 -(152 + 16)) + 458))) and (v149==0)) then v150=0 + 0;v151=nil;v149=642 -(461 + 180);end if ((v149==(19 -(15 + 3))) or ((4475 -(150 + 398))<((3575 -1211) -(44 + 139)))) then while true do if (((3166 + 1114 + 371)>=(8134 -(6360 -(66 + 198)))) and (v150==(0 + 0))) then v151=v101[3 -1];v99[v151]=v99[v151](v12(v99,v151 + 1 + 0,v101[1748 -(179 + 1566)]));break;end end break;end end end elseif (((2030 + 424)>(903 + 272)) and (v102==(21 -10))) then local v152=1098 -(389 + 709);local v153;local v154;while true do if (((2183 + 1926)>(3931 -(296 + 402))) and (v152==(2 -1))) then while true do if ((v153==(0 + 0)) or ((1513 + 1875)==(2334 -925))) then v154=v101[1410 -(343 + 1065)];v99[v154]=v99[v154]();break;end end break;end if (((4134 -(1887 + (263 -151)))>((3486 -(1267 + 462)) -(1499 -(163 + 194)))) and (v152==(453 -(66 + 387)))) then v153=0 -0;v154=nil;v152=1407 -(293 + 1113);end end else local v155=(0 + 0) -0;local v156;while true do if (((1207 -(12 + 7))<=(2813 -(441 + 336))) and ((112 -((1531 -(1340 + 143)) + 64))==v155)) then v156=v101[1921 -(719 + 1200)];v99[v156](v99[v156 + (562 -(374 + (528 -341)))]);break;end end end elseif (((4700 -((596 -380) + 1750))<=(7296 -3727)) and (v102<=((223 -158) -(454 -(10 + 398))))) then if ((v102<=(1755 -(97 + 1643))) or (((27323 -15569) -8309)>=(6049 -(141 + 1523)))) then if (((370 + 3750)>859) and (v102<=(3 + 10))) then v99[v101[(3068 -2417) -(196 + 453)]]=v36[v101[3 + 0]];elseif (((44 + (96 -35))==(36 + 69)) and (v102==(1209 -(623 + 572)))) then local v157=0 + 0;local v158;local v159;local v160;while true do if (((904 + 83)==(1505 -((1422 -1046) + 142))) and (v157==(5 -(8 -5)))) then for v186=1,v101[18 -14] do local v187=(471 + 1247) -((1821 -1266) + 445 + 718);local v188;while true do if ((v187==0) or ((3712 -(3369 -2196))<(5622 -3545))) then local v202=0 -(1893 -(1179 + 714));while true do if (((1024 -(709 + 314))==v202) or (((2569 -(834 + 5)) + 141)>=(1754 + 1826))) then v187=1 + 0;break;end if ((((12247 -7636) -(363 + 1028))<=(4490 -(828 + 126 + 85))) and ((0 -0)==v202)) then v66=v66 + (3 -2);v188=v92[v66];v202=1 + 0;end end end if (((12613 -9130)<=(5695 -(681 + (4918 -3738)))) and ((798 -(426 + 371))==v187)) then if ((v188[1 -0]==((2 + 9) -6)) or ((17087 -13508)>=(2246 + 1935))) then v160[v186-(1693 -(1205 + 345 + 142))]={v99,v188[10 -7]};else v160[v186-(1 + 0)]={v35,v188[5 -2]};end v98[ #v98 + (2 -1)]=v160;break;end end end v99[v101[2]]=v28(v158,v159,v36);break;end if (((13308 -8855)>=(6836 -4797)) and (v157==(775 -(273 + 501)))) then local v181=0 + (762 -(664 + 98));while true do if ((v181==(1 + 0)) or ((18334 -13518)<=(406 + 1497))) then v157=1 + 1;break;end if ((v181==(560 -(132 + 428))) or (((13107 -8937) -2202)>(2411 + 1027))) then v160={};v159=v9({},{__index=function(v204,v205)local v217=(352 -(57 + 295)) -0;local v218;while true do if ((v217==(0 -0)) or ((7969 -4547)==(3687 -2850))) then v218=v160[v205];return v218[2 -1][v218[5 -3]];end end end,__newindex=function(v206,v207,v208)local v219=0 -0;local v220;while true do if ((v219==(0 + 0)) or ((3147 -(1184 + 587))<=(264 + 831))) then v220=v160[v207];v220[2 -1][v220[604 -(65 + 33 + 504)]]=v208;break;end end end});v181=991 -(965 + 25);end end end if (((308 + 1591)>(1457 -590)) and (v157==(0 -0))) then local v182=948 -(322 + 626);while true do if (((5865 -(338 + 91 + 63 + 424))>(1094 -(884 + 146))) and (v182==(326 -(201 + 124)))) then v157=2 -1;break;end if ((v182==(0 + 0)) or ((3979 -1559)==(662 + 2612))) then v158=v94[v101[11 -8]];v159=nil;v182=1 -0;end end end end else local v161=0 -0;local v162;local v163;local v164;while true do if (((0 -0)==v161) or ((8342 -4032)<=(1932 + 1404))) then local v183=381 -(244 + 137);while true do if ((((8984 -4615) -(841 + 611))<(1066 + 2540)) and (v183==(1 + 0))) then v161=2 -1;break;end if ((v183==(0 -(0 -0))) or ((3728 + 1034)<(3479 -((209 -69) + 317)))) then v162=0 -0;v163=nil;v183=1 + 0;end end end if (((3835 -(19 + 8))==(5597 -(1000 + 789))) and (v161==(60 -(39 + 20)))) then v164=nil;while true do if ((v162==(1805 -(1182 + (2466 -(235 + 1609))))) or ((244 + 135)>(94 + 563))) then for v209=1 -(0 + 0), #v98 do local v210=525 -(362 + 163);local v211;local v212;while true do if ((v210==(512 -(150 + 171 + 190))) or (2651==3804)) then while true do if (((2881 -(71 + 120))>=(1276 -(63 + 521))) and (v211==(0 + 0))) then v212=v98[v209];for v235=0 -0, #v212 do local v236=(480 -180) -(215 + 85);local v237;local v238;local v239;local v240;while true do if ((v236==(902 -(305 + 595))) or (((9280 + 1273) -7199)>((9336 -(1174 + 479)) -2974))) then while true do if (((5295 -1815)==(3815 -(58 + 277))) and (v237==0)) then local v246=0 + 0;while true do if ((v246==(0 -0)) or ((661 -528)>(537 -(128 + 153)))) then local v248=0 + 0;while true do if (((2321 + 187)<(7635 -(10880 -6063))) and ((483 -(475 + 8))==v248)) then v238=v212[v235];v239=v238[1 + 0];v248=1 -0;end if (((4292 -(870 + 1115))<=(2063 + 1146)) and (v248==(1967 -(1233 + 733)))) then v246=1 -0;break;end end end if (((1883 + 649)==((8326 -4610) -(687 + 497))) and (v246==(1098 -(91 + 22 + 984)))) then v237=357 -(70 + 286);break;end end end if (((908 + 2103)<=(2969 + 68)) and (1==v237)) then v240=v238[1257 -(318 + 763 + 174)];if (((2455 -(47 + 1068))>(2972 -1918)) and (v239==v99) and (v240>=v163)) then local v247=0;while true do if (((0 + 0)==v247) or ((5056 -((1999 -(705 + 1022)) + 147))<(1698 + 1513))) then v164[v240]=v239[v240];v238[1973 -(1923 + 49)]=v164;break;end end end break;end end break;end if ((v236==(0 + 0)) or ((11387 -7994)>(15204 -11420))) then v237=474 -(136 + 338);v238=nil;v236=1 + 0;end if (((2822 + 951)<(1946 + 2304)) and (v236==(455 -(409 + 45)))) then local v243=0 -0;while true do if ((v243==0) or (4087==((4905 -(1114 + 352)) -(435 + 190)))) then v239=nil;v240=nil;v243=15 -((1889 -(844 + 1040)) + 9);end if ((v243==((1326 -(534 + 791)) + 0)) or ((2117 + 551)>=(4973 -957))) then v236=2 + 0;break;end end end end end break;end end break;end if ((v210==(0 -0)) or ((2993 -(432 + 549))<(464 + 1494))) then v211=0 -0;v212=nil;v210=984 -(860 + 123);end end end break;end if ((v162==(0 + 0)) or ((9422 -5918)<=(4710 -(1623 + (452 -292))))) then local v198=0 + 0;while true do if (((3135 -(11 + 637))<((20597 -(985 + 50)) -14578)) and (v198==(0 + 0))) then local v227=0 + 0;while true do if ((v227==(1216 -(1015 + 200))) or (((4059 -(627 + 1058)) + 1372)==(8351 -4465))) then v198=2 -1;break;end if (((4725 -(66 + 42))>=(466 + 1440)) and (v227==(0 -0))) then v163=v101[877 -(309 + 566)];v164={};v227=1 + 0;end end end if (((1 + 0)==v198) or (((25203 -18923) -(1463 + 161))<=(2659 -(491 + 721)))) then v162=(1 + 1) -1;break;end end end end break;end end end elseif (((8734 -6662)>(2539 -(237 + (2426 -(893 + 759))))) and (v102<=(2006 -(1586 + 403)))) then if (((9204 -5741)>=(3260 -2159)) and (v102==(31 -(42 -27)))) then v99[v101[1727 -(523 + 1202)]]=v101[1 + 2]~=(0 + 0);else v99[v101[7 -5]]=v99[v101[1 + 2]][v101[1569 -(480 + 1085)]];end elseif ((v102==(64 -46)) or (((9178 -(724 + 140)) -4360)==(3801 -(235 + 335)))) then v36[v101[3 -0]]=v99[v101[524 -(161 + 361)]];else v99[v101[(3691 -2326) -(1293 + 70)]]=v101[631 -(340 + 288)];end elseif (((4063 -(1404 + 246))<=(6382 -3047)) and (v102<=(36 -14))) then if ((v102<=(1619 -((1957 -(1581 + 129)) + 1352))) or ((5195 -((696 -481) + 9))<=(3438 -(2303 -(39 + 314))))) then do return v99[v101[4 -2]];end elseif ((v102==(1434 -(1053 + 360))) or ((5639 -3108)<=(4869 -(3507 + 130)))) then v99[v101[510 -(362 + 146)]]=v35[v101[1 + 2]];else for v176=v101[1288 -(1043 + 243)],v101[10 -7] do v99[v176]=nil;end end elseif ((v102<=(23 + 1)) or ((1128 + (3151 -1950))==(9707 -5083))) then if (((4602 -(122 + 835))<=((5579 -(1237 + 679)) + 696)) and (v102==(20 + 3))) then if ((v101[1 + 1]==v99[v101[4]]) or ((880 -(233 + 148))>((629 -177) + 3920))) then v66=v66 + ((2444 -1268) -(766 + (1084 -(133 + 542))));else v66=v101[6 -3];end else v66=v101[1141 -(164 + 974)];end elseif (((3670 -(307 + 587))>=(5851 -3328)) and (v102==(55 -30))) then do return;end else local v170=423 -(74 + 349);local v171;local v172;local v173;local v174;local v175;while true do if ((v170==(1 + 0)) or ((9090 -5997)>=(1729 + 3126))) then v173=nil;v174=nil;v170=262 -(28 + 232);end if ((v170==(2 + 0 + 0)) or ((12760 -9111)<((931 -(49 + 89)) -350))) then v175=nil;while true do if (((1525 -(338 + 776))<=(4343 -((2195 -1363) + 607))) and ((1 + 1)==v171)) then for v213=v172,v67 do local v214=0 -0;while true do if ((v214==(0 -0)) or ((2559 -677)==(2914 + 936))) then v175=v175 + 1;v99[v213]=v173[v175];break;end end end break;end if ((v171==(1 -0)) or (4974<=(956 + 37))) then local v199=0 + 0;while true do if (((1034 -(195 + 838))==v199) or ((200 -46)==(9255 -4651))) then v171=438 -(204 + 163 + 69);break;end if (((1027 -(129 + 898))==v199) or ((2669 -(638 + 282 + 76))>(5039 -(360 + 1)))) then v67=(v174 + v172) -(4 -3);v175=0 + 0;v199=2 -1;end end end if (((8329 -6634)>=((381 + 442) -237)) and (v171==(0 + 0))) then local v200=0 -0;while true do if (((239 + 109)<=(6463 -((2442 -(1650 + 31)) + 1023 + 147))) and (v200==(0 -(976 -(466 + 510))))) then v172=v101[1115 -((217 -132) + 1028)];v173,v174=v96(v99[v172](v12(v99,v172 + (1 -0),v101[3])));v200=1;end if ((((1533 -(35 + 151)) -(358 + 953))==(177 -141)) and (v200==(2 -1))) then v171=(67 -(44 + 20)) -2;break;end end end end break;end if ((((2162 -(1069 + 810)) -(57 + 125))<=(5979 -3956)) and (v170==(1267 -(161 + 1106)))) then v171=0 + 0;v172=nil;v170=1 + 0;end end end v66=v66 + (1 -0);break;end if (((7038 -4321)>(68 + 71 + 816)) and (v106==(366 -(269 + 97)))) then local v112=229 -(169 + 60);while true do if (((6078 -(710 + 847))>=(11825 -(10152 -(1076 + 459)))) and (v112==(456 -((2357 -(556 + 1414)) + 68)))) then v106=1;break;end if (((2113 + 1638)>(2625 -(81 + 116))) and (v112==(0 + 0))) then local v121=1571 -(822 + 749);while true do if ((v121==(1 -0)) or ((9946 -6333)==(63 + 410 + 1962))) then v112=1557 -(1412 + (271 -127));break;end if ((v121==(759 -(448 + 311))) or ((616 + 840)>=(19624 -14666))) then v101=v92[v66];v102=v101[327 -(184 + 142)];v121=3 -2;end end end end end end break;end end end end v65=3;end if (v65==3) then A,B=v26(v10(v70));if  not A[1] then local v103=v34[4][v66] or "?";error("Script error at ["   .. v103   .. "]:"   .. A[2]);else return v12(A,2,B);end break;end if (v65==0) then v66=1;v67= -1;v65=1;end end end;end return v28(v27(),{},v16)();end v14("LOL!283O00028O00026O00F03F027O0040030A3O00636865636B5F6877696403043O00687769642O0103043O0067616D6503073O00506C6163654964022O00F0C2E236FB412O033O006E657703073O0073752O63652O73030D3O00466F756E64207363726970742E030A3O004C6F6164696E673O2E030A3O006C6F6164737472696E6703073O00482O7470476574034F3O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F783366612O6C336E616E67656C2F46612O6C416E67656C4875622F6D61696E2F546178695F426F2O732E6C756103063O0064656C657465022O003013D884FC41035F3O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F783366612O6C336E616E67656C2F46612O6C416E67656C4875622F6D61696E2F416E696D6525323042612O746C6567726F756E6473253230582E6C7561022O0030CAE0CDFA4103683O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F783366612O6C336E616E67656C2F46612O6C416E67656C4875622F6D61696E2F4A6F6A6F253230546865253230446179253230456E6425323045766F6C7574696F6E2E6C7561022O0010511276F741022O0090AB390EF94103553O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F783366612O6C336E616E67656C2F46612O6C416E67656C4875622F6D61696E2F546974616E253230576172666172652E6C7561022O00B899BDDA014203523O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F783366612O6C336E616E67656C2F46612O6C416E67656C4875622F6D61696E2F536861646F7669735F5250472E6C7561034D3O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F47537374617247616D65722F526F626C6F782D4578706C6F6974732F6D61696E2F6C6F616465722E6C7561030A3O0056616C6964204857494403083O00456E6A6F79203A44010003053O00652O726F72030C3O00496E76616C6964204857494403313O00506C6561736520636865636B20696620796F75206861766520656E74657265642074686520636F2O72656374204857494403583O00682O7470733A2O2F7261772E67697468756275736572636F6E74656E742E636F6D2F4A7865726561732F55492D4C69627261726965732F6D61696E2F6E6F74696669636174696F6E5F6775695F6C6962726172792E6C756103043O00696E666F030D3O00436865636B696E67204857494403123O0049662069747320696E20746865206C697374030A3O004765745365727669636503133O00526278416E616C797469637353657276696365030B3O00476574436C69656E7449640012012O0012133O00014O0016000100053O00264O0007000100010004183O00070001001213000100014O0016000200023O0012133O00023O00264O000B2O0100030004183O000B2O012O0016000500053O00262O000100E2000100030004183O00E2000100120D000600043O00120D000700054O00080006000200022O0005000500063O00262O000500DA000100060004183O00DA0001001213000600014O0016000700083O00262O000600D3000100020004183O00D3000100262O000700BE000100020004183O00BE000100120D000900073O00201100090009000800262O00090035000100090004183O00350001001213000900014O0016000A000A3O00262O0009002E000100010004183O002E0001002011000B0002000A001213000C000B3O001213000D000C3O001213000E000D4O000A000B000E00022O0005000A000B3O00120D000B000E3O00120D000C00073O002001000C000C000F001213000E00104O001A000C000E4O0002000B3O00022O0003000B00010001001213000900023O00262O0009001E000100020004183O001E0001002001000B000A00112O000C000B000200010004183O00BB00010004183O001E00010004183O00BB000100120D000900073O00201100090009000800262O00090063000100120004183O00630001001213000900014O0016000A000B3O00262O00090040000100010004183O00400001001213000A00014O0016000B000B3O001213000900023O00262O0009003B000100020004183O003B000100262O000A005A000100010004183O005A0001001213000C00013O00262O000C0049000100020004183O00490001001213000A00023O0004183O005A000100262O000C0045000100010004183O00450001002011000D0002000A001213000E000B3O001213000F000C3O0012130010000D4O000A000D001000022O0005000B000D3O00120D000D000E3O00120D000E00073O002001000E000E000F001213001000134O001A000E00104O0002000D3O00022O0003000D00010001001213000C00023O0004183O00450001000E17000200420001000A0004183O00420001002001000C000B00112O000C000C000200010004183O00BB00010004183O004200010004183O00BB00010004183O003B00010004183O00BB000100120D000900073O00201100090009000800262O00090076000100140004183O0076000100201100090002000A001213000A000B3O001213000B000C3O001213000C000D4O000A0009000C000200120D000A000E3O00120D000B00073O002001000B000B000F001213000D00154O001A000B000D4O0002000A3O00022O0003000A00010001002001000A000900112O000C000A000200010004183O00BB000100120D000900073O0020110009000900080026090009007E000100160004183O007E000100120D000900073O00201100090009000800262O00090097000100170004183O00970001001213000900014O0016000A000A3O00262O00090090000100010004183O00900001002011000B0002000A001213000C000B3O001213000D000C3O001213000E000D4O000A000B000E00022O0005000A000B3O00120D000B000E3O00120D000C00073O002001000C000C000F001213000E00184O001A000C000E4O0002000B3O00022O0003000B00010001001213000900023O00262O00090080000100020004183O00800001002001000B000A00112O000C000B000200010004183O00BB00010004183O008000010004183O00BB000100120D000900073O00201100090009000800262O000900B4000100190004183O00B40001001213000900014O0016000A000A3O000E17000200A2000100090004183O00A20001002001000B000A00112O000C000B000200010004183O00BB000100262O0009009D000100010004183O009D0001002011000B0002000A001213000C000B3O001213000D000C3O001213000E000D4O000A000B000E00022O0005000A000B3O00120D000B000E3O00120D000C00073O002001000C000C000F001213000E001A4O001A000C000E4O0002000B3O00022O0003000B00010001001213000900023O0004183O009D00010004183O00BB000100120D0009000E3O00120D000A00073O002001000A000A000F001213000C001B4O001A000A000C4O000200093O00022O00030009000100010020010009000800112O000C0009000200010004183O00102O01000E1700010016000100070004183O00160001001213000900013O00262O000900C5000100020004183O00C50001001213000700023O0004183O0016000100262O000900C1000100010004183O00C10001002001000A000300112O000C000A00020001002011000A0002000A001213000B000B3O001213000C001C3O001213000D001D4O000A000A000D00022O00050008000A3O001213000900023O0004183O00C100010004183O001600010004183O00102O0100262O00060014000100010004183O00140001001213000700014O0016000800083O001213000600023O0004183O001400010004183O00102O0100262O000500102O01001E0004183O00102O0100201100060002000A0012130007001F3O001213000800203O001213000900214O00070006000900010004183O00102O0100262O000100FC000100010004183O00FC0001001213000600013O00262O000600F7000100010004183O00F7000100120D0007000E3O00120D000800073O00200100080008000F001213000A00224O0010000B00014O001A0008000B4O000200073O00022O000B0007000100022O0005000200073O00201100070002000A001213000800233O001213000900243O001213000A00254O000A0007000A00022O0005000300073O001213000600023O00262O000600E5000100020004183O00E50001001213000100023O0004183O00FC00010004183O00E5000100262O0001000A000100020004183O000A000100120D000600073O002001000600060026001213000800274O000A0006000800020020010006000600282O00080006000200022O0005000400063O00060E00063O000100012O00053O00043O002O12000600043O001213000100033O0004183O000A00010004183O00102O01000E170002000200013O0004183O000200012O0016000300043O0012133O00033O0004183O000200012O000F8O00193O00013O00013O000A3O00028O00026O00F03F03053O00747275657D03063O0066616C73657D03043O0067616D6503073O00482O747047657403553O00682O7470733A2O2F75633463346D692O346C2O763267336F6D6270737A786B71746D306C78647A6F2E6C616D6264612D75726C2E61702D6E6F727468656173742D312E6F6E2E6177732F636865636B3F687769643D03053O0073706C697403013O003A027O004001313O001213000100014O0016000200043O00262O0001002A000100020004183O002A00012O0016000400043O00262O00020011000100020004183O0011000100262O0004000C000100030004183O000C00012O0010000500014O0014000500023O0004183O0030000100262O00040030000100040004183O003000012O001000056O0014000500023O0004183O0030000100262O00020005000100010004183O00050001001213000500013O00262O00050023000100010004183O0023000100120D000600053O002001000600060006001213000800074O001500096O00060008000800092O000A0006000800022O0005000300063O0020110006000300082O0005000700033O001213000800094O000A00060008000200201100040006000A001213000500023O00262O00050014000100020004183O00140001001213000200023O0004183O000500010004183O001400010004183O000500010004183O0030000100262O00010002000100010004183O00020001001213000200014O0016000300033O001213000100023O0004183O000200012O00193O00017O00313O009E3O009F3O00A33O00A33O00A43O00A63O00A63O00A73O00A73O00A83O00A83O00A83O00A93O00A93O00AA3O00AA3O00AC3O00AE3O00AE3O00AF3O00B13O00B13O00B23O00B23O00B23O00B23O00B23O00B23O00B23O00B33O00B33O00B33O00B33O00B33O00B43O00B63O00B63O00B73O00B83O00B93O00BB3O00BD3O00BF3O00BF3O00C03O00C13O00C23O00C33O00C53O0012012O00023O00033O00093O00093O000A3O000B3O000C3O000E3O000E3O000F3O00113O00113O00123O00123O00123O00123O00133O00133O00143O00153O00183O00183O001A3O001A3O001B3O001B3O001B3O001B3O001C3O001D3O001F3O001F3O00203O00203O00203O00203O00203O00203O00213O00213O00213O00213O00213O00213O00213O00223O00243O00243O00253O00253O00263O00273O00283O00293O00293O00293O00293O002A3O002B3O002E3O002E3O002F3O00303O00313O00333O00333O00353O00353O00363O00383O00383O00393O003A3O003C3O003C3O003D3O003D3O003D3O003D3O003D3O003D3O003E3O003E3O003E3O003E3O003E3O003E3O003E3O003F3O00403O00433O00433O00443O00443O00453O00463O00483O00493O004A3O004B3O004B3O004B3O004B3O004C3O004C3O004C3O004C3O004C3O004D3O004D3O004D3O004D3O004D3O004D3O004D3O004E3O004E3O004E3O004F3O004F3O004F3O004F3O004F3O004F3O004F3O004F3O00503O00513O00533O00533O00543O00543O00543O00543O00543O00543O00553O00553O00553O00553O00553O00553O00553O00563O00583O00583O00593O00593O005A3O005B3O005C3O005D3O005D3O005D3O005D3O005E3O005F3O00613O00613O00623O00623O00633O00653O00653O00663O00663O00663O00663O00663O00663O00673O00673O00673O00673O00673O00673O00673O00683O00693O006A3O006C3O006C3O006C3O006C3O006C3O006C3O006C3O006E3O006E3O006F3O00713O00713O00723O00743O00743O00753O00763O00783O00783O00793O00793O007A3O007A3O007A3O007A3O007A3O007A3O007B3O007C3O007E3O00803O00823O00823O00833O00843O00853O00863O00873O00883O00883O00893O00893O00893O00893O00893O008B3O008D3O008D3O008E3O00903O00903O00913O00913O00913O00913O00913O00913O00913O00913O00913O00923O00923O00923O00923O00923O00923O00933O00953O00953O00963O00973O00983O009B3O009B3O009C3O009C3O009C3O009C3O009C3O009C3O009C3O00C53O00C53O009D3O00C63O00C73O00C93O00CB3O00CB3O00CC3O00CE3O00CF3O00D03O00D13O00",v8());end
