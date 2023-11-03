#include "Vsinegen.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

#define MAX_SIM_CYC 1000000
#define ADDRESS_WIDTH 8
#define ROM_SZ 256

int main(int argc, char ** argv, char ** env){
    int simcyc;
    int clk;

    Verilated::commandArgs(argc, argv);
    Vsinegen*top = new Vsinegen;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top -> trace(tfp, 99);
    tfp -> open("Vsinegen.vcd");

    if(vbdOpen()!=1) return (-1);
    vbdHeader("L2t2: DualWave");

    top -> clk = 1;
    top -> rst = 0;
    top -> en = 1;
    top -> incr = 1;
    top -> offset = vbdValue();

    for(simcyc = 0; simcyc < MAX_SIM_CYC; simcyc++){
        for(clk = 0; clk < 2; clk++){
            tfp -> dump(2*simcyc+clk);
            top -> clk = !(top -> clk);
            top -> eval();
        }
        vbdPlot(int(top -> dout1), 0, 255);
        vbdPlot(int(top -> doutOffset), 0, 255);
        vbdCycle(simcyc);
        
        top -> en = vbdFlag();

        // either simulation finished, or 'q' is pressed
        if ((Verilated::gotFinish()) || (vbdGetkey()=='q')) 
            exit(0);                // ... exit if finish OR 'q' pressed
    }

    tfp -> close();
    exit(0);

}