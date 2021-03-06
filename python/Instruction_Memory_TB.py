from myhdl import Signal, Simulation, intbv, traceSignals
from Instruction_Memory import Instruction_Memory
from helpers.Clock_Generator import clock_generator
from helpers.Random_Signal import random_signal
from helpers.Match_Test import match_test_report
from helpers.Paths import INDEX_256
  
# Program Counter Testbench
# Runs the PC for max_cycles
# Gives the branch signal and a new address every 10 cycles
if (__name__ == "__main__"):
    MAX_CYCLES = 1000
    test_file = INDEX_256

    address = Signal(intbv(0, 0, 2**32))
    out  = Signal(intbv(0, 0, 2**32))
    clk = Signal(0)

    instruction_driver = traceSignals(Instruction_Memory(clk, address, out, test_file))
    clock_driver = clock_generator(clk)
    rand_driver = random_signal(clk, address)

    sim = Simulation(clock_driver, rand_driver, instruction_driver)
    sim.run(MAX_CYCLES)
