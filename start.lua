serpent = dofile("./libs/serpent.lua")
https = require("ssl.https")
http = require("socket.http")
JSON = dofile("./libs/JSON.lua")
local database = dofile("./libs/redis.lua").connect("127.0.0.1", 6379)
Server_SPIRTA = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
local AutoFiles_SPIRTA = function() 
local Create_Info = function(Token,Sudo,UserName)  
local SPIRTA_Info_Sudo = io.open("sudo.lua", 'w')
SPIRTA_Info_Sudo:write([[
token = "]]..Token..[["
Sudo = ]]..Sudo..[[  
]])
SPIRTA_Info_Sudo:close()
end  
if not database:get(Server_SPIRTA.."Token_SPIRTA") then
print("\27[1;34m»» Send Your Token Bot :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31m»» Sorry The Token is not Correct \n\27[0;39;49m')
else
io.write('\n\27[1;31m»» The Token Is Saved\n\27[0;39;49m')
database:set(Server_SPIRTA.."Token_SPIRTA",token)
end 
else
io.write('\n\27[1;31mThe Tokem was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
if not database:get(Server_SPIRTA.."Id_SPIRTA") then
print("\27[1;34m\n»» Send Your id Sudo : \27[m")
local UserName = io.read():gsub('@','')
if UserName ~= '' then
io.write('\n\27[1;31m»» The id Is Saved\n\27[0;39;49m')
database:set(Server_SPIRTA.."Id_SPIRTA",UserName)
else
io.write('\n\27[1;31mThe id was not Saved\n\27[0;39;49m')
end 
os.execute('lua start.lua')
end
local function Files_SPIRTA_Info()
Create_Info(database:get(Server_SPIRTA.."Token_SPIRTA"),database:get(Server_SPIRTA.."Id_SPIRTA"),database:get(Server_SPIRTA.."UserName_SPIRTA"))   
local RunSPIRTA = io.open("SPIRTA", 'w')
RunSPIRTA:write([[
#!/usr/bin/env bash
cd $HOME/SPIRTA
token="]]..database:get(Server_SPIRTA.."Token_SPIRTA")..[["
while(true) do
rm -fr ../.telegram-cli
./tg -s ./SPIRTA.lua -p PROFILE --bot=$token
done
]])
RunSPIRTA:close()
local RunTs = io.open("ts", 'w')
RunTs:write([[
#!/usr/bin/env bash
cd $HOME/SPIRTA
while(true) do
rm -fr ../.telegram-cli
screen -S SPIRTA -X kill
screen -S SPIRTA ./SPIRTA
done
]])
RunTs:close()
end
Files_SPIRTA_Info()
database:del(Server_SPIRTA.."Token_SPIRTA");database:del(Server_SPIRTA.."Id_SPIRTA");database:del(Server_SPIRTA.."UserName_SPIRTA")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
end 
local function Load_File()  
local f = io.open("./sudo.lua", "r")  
if not f then   
AutoFiles_SPIRTA()  
var = true
else   
f:close()  
database:del(Server_SPIRTA.."Token_SPIRTA");database:del(Server_SPIRTA.."Id_SPIRTA");database:del(Server_SPIRTA.."UserName_SPIRTA")
sudos = dofile('sudo.lua')
os.execute('./install.sh ins')
var = false
end  
return var
end
Load_File()