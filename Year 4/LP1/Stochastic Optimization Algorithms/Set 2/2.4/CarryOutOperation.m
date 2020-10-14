function destination = CarryOutOperation(operator, operand1, operand2, divisionByZeroResult)
if operator == 1
    destination = operand1 + operand2;
elseif operator == 2
    destination = operand1 - operand2;
elseif operator == 3
    destination = operand1 * operand2;
elseif operator == 4
    if operand2 == 0
        destination = divisionByZeroResult;
    else
        destination = operand1 / operand2;
    end
else
    error('Operator is %.2f', operator);
end
end

