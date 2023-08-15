--> Constants
local function getService(name: string)
	local service = nil;

	pcall(function()
		service = game:GetService(name);
	end);

	return service;
end;

--> Services
local players = getService('Players');
local marketPlaceService = getService('MarketplaceService');

--> Whitelisted
local whitelist = {
	game.CreatorId;
	266723646;
	305656041;
	1734347497;
};

--> Class
local Passes = {
	Ids = {
		['VIP'] = 208247118;
		['x2Coins'] = 211562941;
		['NameColor'] = 211563039;
	};
};

local function hasPass(player: Player, id: number)
	local has = false
	
	if marketPlaceService:UserOwnsGamePassAsync(player.UserId, id) then
		has = true
	end
	
	for name: string, passId: number in pairs(Passes.Ids) do
		if passId == id then
			if player:GetAttribute(name) ~= nil and player:GetAttribute(name) == true then
				has = true
			end
		end
	end
	
	return has;
end;

local function isWhitelisted(player: Player)
	return (table.find(whitelist, player.UserId) ~= nil and true) or false;
end;

function Passes.loadPasses(player: Player)
	for name: string, id: number in pairs(Passes.Ids) do
		if hasPass(player, id) and isWhitelisted(player) == false then
			player:SetAttribute(name, true);
		elseif isWhitelisted(player) == true then
			player:SetAttribute(name, true);
		end;
	end;
end;

function Passes.boughtPass(player: Player, passId: number)
	for name: string, id: number in pairs(Passes.Ids) do
		if id == passId then
			player:SetAttribute(name, true);
		end;
	end;
end;

function Passes.hasPass(player: Player, passNameOrId)
	if tonumber(passNameOrId) then
		return hasPass(player, passNameOrId);
	else
		local passId = '';

		for name: string, id: number in pairs(Passes.Ids) do
			if name == passNameOrId then
				passId = id;
			end;
		end;

		return hasPass(player, passId);
	end;
end;

return Passes;
