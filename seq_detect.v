//检测序列1001
//三段式状态机
module seq_detect(
	input clk,
	input rst_n,
	input sin,
	output reg detect_valid
	);

parameter IDLE = 5'b00001;
parameter S1 = 5'd00010;
parameter S2 = 5'd00100;
parameter S3 = 5'd01000;
parameter S4 = 5'd10000;

reg [4:0] cstate;
reg [4:0] nstate;

// 第一段，状态转移
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cstate <= IDLE;
	end
	else begin
		cstate <= nstate;
	end
end

// 第二段，决定下一个状态
always @(*) begin
	case(cstate)
		IDLE:
			if (sin==1'b1) begin
				nstate = S1;
			end
			else begin
				nstate = IDLE;
			end

		S1:
			if (sin==1'b0) begin
				nstate = S2;
			end
			else begin
				nstate = S1;
			end

		S2:
			if (sin==1'b0) begin
				nstate = S3;
			end
			else begin
				nstate = S1;
			end

		S3:
			if (sin==1'b1) begin
				nstate = S4;
			end
			else begin
				nstate = IDLE;
			end

		S4:
			if (sin==1'b0) begin
				nstate = S2;
			end
			else if (sin==1'b1) begin
				nstate = S1;
			end
			else begin
				nstate = IDLE;
			end

		default:nstate = IDLE;
	endcase
end

// 第三段，决定输出（时序逻辑）
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		detect_valid <= 1'b0;
	end
	else if (nstate==S4) begin
		detect_valid <= 1'b1;
	end
	else begin
		detect_valid <= 1'b0;
	end
end

endmodule




//检测序列1001
//两段式状态机
module seq_detect(
	input clk,
	input rst_n,
	input sin,
	output detect_valid
	);

parameter IDLE = 4'b0001;
parameter S1 = 4'd0010;
parameter S2 = 4'd0100;
parameter S3 = 4'd1000;

reg [3:0] cstate;
reg [3:0] nstate;

// 第一段，状态转移
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cstate <= IDLE;
	end
	else begin
		cstate <= nstate;
	end
end

// 第二段，决定下一个状态
always @(*) begin
	case(cstate)
		IDLE:
			if (sin==1'b1) begin
				nstate = S1;
			end
			else begin
				nstate = IDLE;
			end

		S1:
			if (sin==1'b0) begin
				nstate = S2;
			end
			else begin
				nstate = S1;
			end

		S2:
			if (sin==1'b0) begin
				nstate = S3;
			end
			else begin
				nstate = S1;
			end

		S3:
			if (sin==1'b1) begin
				nstate = S1;
			end
			else begin
				nstate = IDLE;
			end

		default:nstate = IDLE;
	endcase
end

// 组合逻辑输出
assign detect_valid = (cstate==S3 && sin==1'b1);

endmodule
