%% Initialization
clear; clc;
%% Parameters
initialQValue = 1;
initial_epsilon = 1;
alpha = 1;
max_epochs = 10000;
%% Training
player1QTable = InitializeQTable;
player2QTable = InitializeQTable;

state0 = zeros(3);


epsilon = initial_epsilon;
%%
results = zeros(1,max_epochs);
for epoch = 1:max_epochs
    if mod(epoch, 100) == 0
        epsilon = epsilon/10;
    end
    state = state0;
    visitedStateIndices = zeros(1,9);
    moveIndices = zeros(1,9);
    for t = 1:9
        numberOfTurns = t;
        currentStateIndex = stateToNumber(state);
        visitedStateIndices(t) = currentStateIndex;
        [qValues, player1QTable, player2QTable] = GetStateQValues(state, player1QTable, player2QTable, t, initialQValue);
        [state, move] = MakeMove(currentStateIndex, t, player1QTable, player2QTable, epsilon);
        moveIndices(t) = move;
        if t > 4
            player1reward = GetReward(state);
            if player1reward ~= 0
                break
            end
        end
    end
    results(epoch) = GetReward(state);
    [player1QTable, player2QTable] = updateQTables(state, player1QTable, player2QTable, moveIndices, visitedStateIndices, numberOfTurns, alpha);
end
%%
clf
hold on
for epoch = 100:10:max_epochs
    results_window = results(epoch-99:epoch);
    win_frequency = numel(find(results_window==1))/100;
    plot(epoch, win_frequency, 'rx')
    draw_frequency = numel(find(results_window == 0))/100;
    plot(epoch, draw_frequency, 'bx')
    lose_frequency = numel(find(results_window == -1))/100;
    plot(epoch, lose_frequency, 'gx')
end
%% Functions

function [player1QTable, player2QTable] = updateQTables(state, player1QTable, player2QTable, moveIndices, visitedStateIndices, numberOfTurns, alpha)
    [player1reward, player2reward] = GetReward(state);
    
    % PLAYER 1 WINS
    if player1reward == 1
        % Player 1
        t = numberOfTurns;
        move = moveIndices(t);
        visitedStateIndex = visitedStateIndices(t);
        player1QTable(2, visitedStateIndex).entry(move) = ...
            player1QTable(2, visitedStateIndex).entry(move) + alpha;
    
        for t = numberOfTurns-2:-2:1
            visitedStateIndex = visitedStateIndices(t);
            nextVisitedStateIndex = visitedStateIndices(t+2);
            move = moveIndices(t);
    
            player1QTable(2, visitedStateIndex).entry(move) = ...
                player1QTable(2, visitedStateIndex).entry(move) + alpha*(...
                    player1reward - ...
                    player1QTable(2, visitedStateIndex).entry(move) + ...
                    max(max(player1QTable(2, nextVisitedStateIndex).entry)));
        end
        
        % Player 2
        t = numberOfTurns - 1;
        move = moveIndices(t);
        visitedStateIndex = visitedStateIndices(t);
        player2QTable(2, visitedStateIndex).entry(move) = -1;
    
        for t = numberOfTurns-3:-2:2
            visitedStateIndex = visitedStateIndices(t);
            nextVisitedStateIndex = visitedStateIndices(t+2);
            move = moveIndices(t);
    
            player2QTable(2, visitedStateIndex).entry(move) = ...
                player2QTable(2, visitedStateIndex).entry(move) + alpha*(...
                    player2reward - ...
                    player2QTable(2, visitedStateIndex).entry(move) + ...
                    max(max(player2QTable(2, nextVisitedStateIndex).entry)));
        end
    
    % PLAYER 2 WINS
    elseif player1reward == -1
        % Player 1
        t = numberOfTurns - 1;
        move = moveIndices(t);
        visitedStateIndex = visitedStateIndices(t);
        player1QTable(2, visitedStateIndex).entry(move) = -1;
    
        for t = numberOfTurns-3:-2:1
            visitedStateIndex = visitedStateIndices(t);
            nextVisitedStateIndex = visitedStateIndices(t+2);
            move = moveIndices(t);
    
            player1QTable(2, visitedStateIndex).entry(move) = ...
                player1QTable(2, visitedStateIndex).entry(move) + alpha*(...
                    player1reward - ...
                    player1QTable(2, visitedStateIndex).entry(move) + ...
                    max(max(player1QTable(2, nextVisitedStateIndex).entry)));
        end
    
        % Player 2
        t = numberOfTurns;
        visitedStateIndex = visitedStateIndices(t);
        move = moveIndices(t);
        player2QTable(2, visitedStateIndex).entry(move) = ...
            player2QTable(2, visitedStateIndex).entry(move) + alpha;
    
        for t = numberOfTurns-2:-2:2
            visitedStateIndex = visitedStateIndices(t);
            nextVisitedStateIndex = visitedStateIndices(t+2);
            move = moveIndices(t);
    
            player2QTable(2, visitedStateIndex).entry(move) = ...
                player2QTable(2, visitedStateIndex).entry(move) + alpha*(...
                    player2reward - ...
                    player2QTable(2, visitedStateIndex).entry(move) + ...
                    max(max(player2QTable(2, nextVisitedStateIndex).entry)));
        end
    
    % DRAW
    else
        % Player 1
        t = numberOfTurns;
        move = moveIndices(t);
        visitedStateIndex = visitedStateIndices(t);
        player1QTable(2, visitedStateIndex).entry(move) = ...
            player1QTable(2, visitedStateIndex).entry(move) + alpha;
    
        for t = numberOfTurns-2:-2:1
            visitedStateIndex = visitedStateIndices(t);
            nextVisitedStateIndex = visitedStateIndices(t+2);
            move = moveIndices(t);
    
            player1QTable(2, visitedStateIndex).entry(move) = ...
                player1QTable(2, visitedStateIndex).entry(move) + alpha*(...
                    player1reward - ...
                    player1QTable(2, visitedStateIndex).entry(move) + ...
                    max(max(player1QTable(2, nextVisitedStateIndex).entry)));
        end
    
        % Player 2
        t = numberOfTurns - 1;
        move = moveIndices(t);
        visitedStateIndex = visitedStateIndices(t);
        player2QTable(2, visitedStateIndex).entry(move) = -1;
    
        for t = numberOfTurns-3:-2:2
            visitedStateIndex = visitedStateIndices(t);
            nextVisitedStateIndex = visitedStateIndices(t+2);
            move = moveIndices(t);
    
            player2QTable(2, visitedStateIndex).entry(move) = ...
                player2QTable(2, visitedStateIndex).entry(move) + alpha*(...
                    player2reward - ...
                    player2QTable(2, visitedStateIndex).entry(move) + ...
                    max(max(player2QTable(2, nextVisitedStateIndex).entry)));
        end
    end

end

function [player1reward, player2reward] = GetReward(state)
    for i = 1:3
        if all(state(i, :) == 1) || all(state(:,i) == 1)
            player1reward = 1; player2reward = -1;
            return
        elseif all(state(i,:) == -1) || all(state(:,i) == -1)
            player1reward = -1; player2reward = 1;
            return
        end
    end        
    i = [1,2,3];
    if all(diag(state) == 1) || all(flip(diag(state)) == 1)
        player1reward = 1; player2reward = -1;
    elseif all(diag(state) == -1) || all(flip(diag(state) == -1))
        player1reward = -1; player2reward = 1;
    else
        player1reward = 0; player2reward = 0;
    end
end


function [qValues, player1QTable, player2QTable] = GetStateQValues(state, player1QTable, player2QTable, t, initialQValue);
    if mod(t,2) == 1
        qTable = player1QTable;
    else
        qTable = player2QTable;
    end
    currentStateIndex = stateToNumber(state);
    if(isempty(qTable(2, currentStateIndex).entry))
        qTable(1, currentStateIndex).entry = state;
        qValues = ones(3)*initialQValue;
        qValues(state ~= 0) = NaN;
        qTable(2, currentStateIndex).entry = qValues;
    else
        qValues = qTable(2, currentStateIndex).entry;
    end
    if mod(t,2) == 1
        player1QTable = qTable;
    else
        player2QTable = qTable;
    end
end

function [newState, move] = MakeMove(currentStateIndex, t, player1QTable, player2QTable, epsilon)
    if mod(t,2) == 1
        qTable = player1QTable;
    else
        qTable = player2QTable;
    end
    state   = qTable(1, currentStateIndex).entry;
    qValues = qTable(2, currentStateIndex).entry;
    
    newState = state;
    playerMove = mod(t,2)*2-1;
    r = rand;
    
    if r < epsilon
        possibleMoves = find(~isnan(qValues));
    else
        possibleMoves = find(qValues == max(max(qValues)));
    end
    move = possibleMoves(randi(numel(possibleMoves)));
    newState(move) = playerMove;
end

function qTable = InitializeQTable
    qTable(2, 19683) = struct('entry',[]);
end

function number = stateToNumber(state)
    state = state+1;
    number = 1;
    for i = 1:9
        number = number+state(10-i)*3^(i-1);
    end
end

function testStateToNumber()
    for i = 0:19682
        stringArray = double(string(num2cell(dec2base(i,3))));
        state = reshape([zeros(1, 9-length(stringArray)), stringArray],3,3)-1;
        assert(stateToNumber(state) == i+1);
    end
end