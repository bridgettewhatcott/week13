//only logic in the modules besides top. do not wire to any leds or switches or buttons unless in top
module top(
    output [6:0] led,
    input btnC, //clk
    input btnU, //reset
    output [2:0] current_state
);
//here is where you would hook up your ripple and modulo to the leds and buttons
//make sure that there is an endmodule after which should not be an error when you put the other stuff in
//modules

//Ripple Segment
//put these in a module called ripple or something
wire [2:0] Next;

tff zero(
    .T(1),
    .store(clk),
    .Q(Next[0]),
    .Q(led[0]), //wire to logic or basic outputs not leds yet!
//  .led(Next[0]),
    .reset(btnU)
);

tff one(
    .T(1),
    .store(Next[0]),
    .Q(Next[1]),
    .led(Next[1]),
    .reset(btnU) //wire to logic or basic outputs not leds yet!
);

tff two(
    .T(1),
    .store(Next[1]),
    .Q(Next[2]),
    .led(Next[2]),
    .reset(btnU) //wire to logic or basic outputs not leds yet!
);


//Modulo Segment
//put these in a module called moduluo or something
wire [2:0] Next;
wire [2:0] TTN;
wire [2:0] Qmove;
wire theEnd;
wire int_reset;

full_adder adderOne(
    .A(Qmove[0]), 
    .B(1'b1), 
    .cin(0),
    .Y(Next[0]),
    .cout(TTN[0])
);

dff dZero(
    .D(Next[0]), 
    .store(clk),
    .Q(Qmove[0]),
    .led(current_state[0]),
    .reset(btnU)
);

full_adder adderTwo(
    .A(Qmove[1]), 
    .B(0), 
    .cin(TTN[0]),
    .Y(Next[1]),
    .cout(TTN[1])
);

dff done(
    .D(Next[1]),
    .store(clk),
    .Q(Qmove[1]),
    .led(current_state[1]),
    .reset(btnU)
);

full_adder adderThree(
    .A(Qmove[2]), 
    .B(0), 
    .cin(TTN[1]),
    .Y(Next[2]),
    .cout(TTN[2])
);

dff dtwo(
    .D(Next[2]),
    .store(clk),
    .Q(Qmove[2]),
    .led(current_state[2]),
    .reset(btnU)
);

comparator comparatorOnly(
    .bitZero(Qmove[0]),
    .bitOne(Qmove[1]),
    .bitTwo(Qmove[2]),
    .reset(int_reset)
);


dff finale(
    .D(~final),
    .reset(btnU),
    .store(int_reset),
    .Q(final)
);
endmodule


module dff (
    input D,
    input store,
    output reg Q, 
    output NotQ
);
    always @(posedge store)begin
        if(store)
            Q<=D;
        end
     assign NotQ = ~Q;
endmodule


module tff (
input T, store, reset,
output reg Q,
output NotQ
);
    always @(posedge store)begin
        if(T)
            Q<=~Q;
    end
    assign NotQ=~Q;
endmodule


module full_adder(
    input A, B,cin,
    output Y, cout
);
assign cout = (A&B)|(cin&(A|B));
assign Y = cin^A^B;
endmodule


module comparator(
    input bitZero, bitOne, bitTwo, store,
    output reset
);

assign reset = bitTwo & ~bitOne & bitZero;


endmodule