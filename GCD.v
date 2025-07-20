module gcd(input clk,reset,input wire [7:0] a,input wire [7:0] b,output reg[7:0]gcd_final,output reg gcd_ready);
reg [7:0] temp;
reg [7:0] gcd;
reg [1:0] state;

parameter hold = 0,calc = 1,ready = 2;
always @(negedge clk) 
begin
    if (reset) 
	 begin
      state <= hold;
      gcd <= 0;
      gcd_ready <= 0;
    end 
	 else 
	 begin
      case (state)
        hold: 
		  begin
          if (a == 0) 
			 begin
            gcd <= b;
            state <= ready;
            gcd_ready <= 1; 
          end 
			 else 
			 begin
            gcd <= a;
            temp <= b;
            state <= calc;
            gcd_ready <= 0;
          end
        end
        calc: 
		  begin
          if (temp == 0) 
			 begin
            gcd <= gcd;
            state <= ready;
            gcd_ready <= 1; 
          end 
			 else 
			 begin
            gcd <= temp;
            temp <= gcd % temp;
            state <= calc;
            gcd_ready <= 0; 
          end
        end
        ready: 
		  begin
          gcd_ready<=1;
        end
      endcase
    end
  end
  always@(*)
  begin
  if(gcd_ready)
		gcd_final <= gcd;
	else
		gcd_final <= 8'bx;
	end
endmodule
