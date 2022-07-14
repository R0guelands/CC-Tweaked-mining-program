_ = turtle

direction = "north"

sideTunnelSize = 0
mainTunnelSize = 0
depth = 0
tunnelHight = 0
doTorch = true

function getInit()
    initX = locateCurrent().x
    initY = locateCurrent().y
    initZ = locateCurrent().z
end

function locateCurrent()
    location = {x, y, z}
    location.x, location.y, location.z = gps.locate()
    return location
end

function distanceFromHome()
    location = locateCurrent()
    return math.abs(location.x - initX) + math.abs(location.y - initY) + math.abs(location.z - initZ)
end

function checkFuel()
    if _.getFuelLevel() - 10 == distanceFromHome() then
        return false
    end
    return true
end

function goHome()

    print(locateCurrent().x, locateCurrent().y, locateCurrent().z)
    print(initX, initY, initZ)

    while distanceFromHome() > 0 do

        if locateCurrent().z > initZ then

            if direction == "north" then
                _.turnRight()
            end

            if direction == "south" then
                _.turnLeft()
            end

            if direction == "west" then
                _.turnRight()
                _.turnRight()
            end

            direction = "east"

            _.forward()
        end

        if locateCurrent().z < initZ then

            if direction == "north" then
                _.turnLeft()
            end

            if direction == "south" then
                _.turnRight()
            end

            if direction == "east" then
                _.turnLeft()
                _.turnLeft()
            end

            direction = "west"
            _.forward()
        end

        if locateCurrent().x > initX and locateCurrent().z == initZ then
            if direction == "east" then
                _.turnRight()
            end
            if direction == "west" then
                _.turnLeft()
            end
            if direction == "south" then
                _.turnRight()
                _.turnRight()
            end
            direction = "north"
            _.forward()
        end

        if locateCurrent().x < initX and locateCurrent().z == initZ then
            if direction == "east" then
                _.turnLeft()
            end
            if direction == "west" then
                _.turnRight()
            end
            if direction == "north" then
                _.turnLeft()
                _.turnLeft()
            end
            direction = "south"
            _.forward()
        end

        if locateCurrent().y < initY and locateCurrent().x == initX and locateCurrent().z == initZ then
            _.up()
        end

    end

    _.turnLeft()
    _.turnLeft()
end

function goToExcavationY()

    while locateCurrent().y ~= depth do

        if checkFuel() == false then
            return
        end

        if _.inspectDown() then
            _.digDown()
            _.down()
        else
            _.down()
        end
    end

end

function dropItens()

    for i = 2, 16 do
        _.select(i)
        if _.getItemCount() > 0 then
            _.drop()
        end
    end

end

function placeToarch()
    if doTorch == true then
        _.select(1)
        _.place()
    end
end

function moveOne()

    if _.inspect() then
        _.dig()
        _.forward()
    else
        _.forward()
    end

end

function digMain()

    for z = 1, mainTunnelSize do
        if isInventoryFull() == true then
            return false;
        end
        xObjective = locateCurrent().x - 4
        i = 0
        while locateCurrent().x ~= xObjective do
            if checkFuel() == false then
                return false
            end
            moveOne()
            if i == 1 then
                _.turnLeft()
                direction = "west"
                if _.inspect() then
                    _.dig()
                end
                placeToarch()
                _.turnRight()
                direction = "north"
            end
            i = i + 1
        end
    
        _.turnLeft()
        direction = "west"
        
        zObjective = locateCurrent().z + sideTunnelSize
        while locateCurrent().z ~= zObjective do
            if checkFuel() == false then
                return false
            end
            moveOne()
        end

        if _.inspect() then
            _.dig()
        end
        placeToarch()
    
        _.turnLeft()
        direction = "south"
        _.turnLeft()
        direction = "east"
        
        zObjective = locateCurrent().z - sideTunnelSize * 2
        while locateCurrent().z ~= zObjective do
            if checkFuel() == false then
                return false
            end
            moveOne()
        end

        if _.inspect() then
            _.dig()
        end

        placeToarch()
    
        _.turnLeft()
        direction = "north"
        _.turnLeft()
        direction = "west"
        
        zObjective = locateCurrent().z + sideTunnelSize 
        while locateCurrent().z ~= zObjective do
            if checkFuel() == false then
                return false
            end
            moveOne()
        end
        _.turnRight()
        direction = "north"
    end

    return true;

end

function calculateFuel()

    print("Input the y level to mine:")
    depth = tonumber(read())
    if depth > locateCurrent().y then
        print("The y level must be lower than your current y level")
        return false
    end
    print("Input the side tunnel size:")
    sideTunnelSize = tonumber(read())

    print("Input the main tunnel number of rounds:")
    mainTunnelSize = tonumber(read())

    print("Input the tunnel hight")
    tunnelHight = tonumber(read())

    total = (locateCurrent().z - depth) + (sideTunnelSize * 2) + (mainTunnelSize * 4) + (tunnelHight * 2)

    if total > _.getFuelLevel() then
        print("You don't have enough fuel to complete this tunnel")
        return false
    end

    return true

end

function doINeedTorch() 

    _.select(1)
    if _.getItemCount() < 32 then
        _.turnLeft()
        _.suck(64 - _.getItemCount())
        _.turnRight()
    end

end

function isInventoryFull() 

    for i = 2, 16 do
        _.select(i)
        if _.getItemCount() == 0 then
            return false
        end
    end
    return true

end

while calculateFuel() == false do
    
end

for i = 1, tunnelHight do
    depth = depth - 1
    if i > 1 then
        doTorch = false
    end
    getInit()
    print(initX, initY, initZ)
    doINeedTorch()
    if checkFuel() == false then
        return
    end
    goToExcavationY()
    if digMain() == false then
        i = i - 1
        depth = depth + 1
    end
    goHome()
    dropItens()
end


