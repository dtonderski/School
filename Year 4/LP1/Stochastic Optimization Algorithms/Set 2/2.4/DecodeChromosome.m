function output = DecodeChromosome(input, chromosome, constants, numberOfRegisters, divisionByZeroResult)
chromosomeLength = length(chromosome);

registers = [input, zeros(1, numberOfRegisters-1)];
operands = [registers, constants];

for iGeneStart= 1:4:chromosomeLength
    operator = chromosome(iGeneStart);
    destinationRegister = chromosome(iGeneStart+1);
    operand1Register = chromosome(iGeneStart+2);
    operand2Register = chromosome(iGeneStart+3);
    if destinationRegister > numberOfRegisters
        error('Destination register %d is bigger than numberOfRegisters', destinationRegister);
    end
    operand1 = operands(operand1Register);
    operand2 = operands(operand2Register);
    operands(destinationRegister) = CarryOutOperation(operator, operand1, operand2, divisionByZeroResult);
end
output = operands(1);
end