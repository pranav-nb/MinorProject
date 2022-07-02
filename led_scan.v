module scan_led(clk1,dig,seg,dis_data);
input clk1;
input [15:0] dis_data;
output reg [7:0] dig; 
output reg [6:0] seg; 
reg [3:0] hundreds;
reg [3:0] tens;
reg [3:0] ones;
reg [7:0] valid_values;
reg[3:0] a=0;
 parameter AN0=8'b11111110,AN1=8'b11111101,AN2 = 8'b11111011,AN3 = 8'b11110111,AN4 = 8'b11101111,AN5 = 8'b11011111,AN6=8'b10111111,AN7=8'b01111111,  
 zero = 7'b100_0000,one = 7'b111_1001,two = 7'b010_0100,three = 7'b011_0000,four = 7'b001_1001,  
               five = 7'b001_0010,six = 7'b000_0010,seven = 7'b111_1000,eigth = 7'b000_0000,nine = 7'b001_0000; 

    integer i;

always @(posedge clk1) 
begin

valid_values[7:0]=dis_data[14:7];
hundreds=4'b0;
tens=4'b0;
ones=4'b0;
for(i=7;i>=0;i=i-1)
begin
    if(hundreds>=5)hundreds=hundreds+3;
    if(tens>=5)tens=tens+3;
    if(ones>=5)ones=ones+3;
    
    hundreds=hundreds<<1;
    hundreds[0]=tens[3];
    tens=tens<<1;
    tens[0]=ones[3];
    ones=ones<<1;
    ones[0]=valid_values[i];
end

if(a==5)a=0;
else a<=a+1'd1; 
               case(a)  
4: begin
         case(dis_data[15])  
           'b0 : seg <= 7'b1111111;  
           'b1 : seg <= 7'b0111111;  
         endcase  
            dig <= AN4;
            end
3:begin  
                    case(hundreds [3:0])  
                    0 : seg <= zero;  
                    1 : seg <= one;  
                    2 : seg <= two;  
                    3 : seg <= three;  
                    4 : seg <= four;  
                    5 : seg <= five;  
                    6 : seg <= six;  
                    7 : seg <= seven;  
                    8 : seg <= eigth;  
                    9 : seg <= nine;  
                    default:seg <= 7'b1111111;  
                    endcase  
                    dig <= AN3; 
                 end  
2:begin  
                    case(tens [3:0])  
                    0 : seg <= zero;  
                    1 : seg <= one;  
                    2 : seg <= two;  
                    3 : seg <= three;  
                    4 : seg <= four;  
                    5 : seg <= five;  
                    6 : seg <= six;  
                    7 : seg <= seven;  
                    8 : seg <= eigth;  
                    9 : seg <= nine;  
                    default:seg <= 7'b1111111;  
                  endcase  
                    dig <= AN2;  
                 end
1:begin
                  case(ones [3:0])  
                    0 : seg <= zero;  
                    1 : seg <= one;  
                    2 : seg <= two;  
                    3 : seg <= three;  
                    4 : seg <= four;  
                    5 : seg <= five;  
                    6 : seg <= six;  
                    7 : seg <= seven;  
                    8 : seg <= eigth;  
                    9 : seg <= nine;  
                    default:seg <= 7'b1111111;  
                  endcase  
                     dig <= AN1;             
               end
0:begin
                       seg <= 7'b1000110; 
                        dig <= AN0;
                        end
            endcase
            end
endmodule

