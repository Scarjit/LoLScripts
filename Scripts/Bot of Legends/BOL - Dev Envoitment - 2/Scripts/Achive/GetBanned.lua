function OnTick()
autolvl(_Q)
autolvl(_W)
autolvl(_E)
autolvl(_R)
Testbuy()
GiveBack()
Testbuy()
GiveBack()
recall()
move()
mastery()
taunt()
laugh()
joke()
end

function lvlspell(id)
  local offsets = { 
    [_Q] = 0x71,
    [_W] = 0xF1,
    [_E] = 0x31,
    [_R] = 0xB1,
  }
  local p = CLoLPacket(0x00DB)
  p.vTable = 0xF6D830
  p:EncodeF(myHero.networkID)
  for i = 1, 4 do p:Encode1(0x30) end
  p:Encode1(0x17)
  for i = 1, 4 do p:Encode1(0x81) end
  for i = 1, 4 do p:Encode1(0x6A) end
  p:Encode1(offsets[id])
  for i = 1, 4 do p:Encode1(0x00) end
  SendPacket(p)
end

function Testbuy()
	local p = CLoLPacket(0x00F2)
	p.vTable = 0xED8C64
	p:EncodeF(myHero.networkID)
	p:Encode1(0x89)
	p:Encode1(0xBA)
	p:Encode1(0x71)
	p:Encode1(0x71)
	p:Encode1(0x00)
	p:Encode1(0x00)
	p:Encode1(0x74)
	p:Encode1(0xD7)
 
  SendPacket(p)
end

function GiveBack()
	local p = CLoLPacket(0x00D8)
	p.vTable = 0xE7A338
	p:EncodeF(myHero.networkID)
	for i = 1, 2 do p:Encode1(0x00) end
	p:Encode1(0xF7)
	p:Encode1(0x06)
	SendPacket(p)
	print("Given Back Item")
end

function SellItem(slot)
	local p = CLoLPacket(0x0059)
	p.vTable = 0xF02A78
	p:EncodeF(myHero.networkID)
	p:Encode1(0x71)
	p:Encode1(0x00)
	p:Encode1(0x6C)
	p:Encode1(0xFC)
	p:Encode1(0x8A)
 
	SendPacket(p)
end

function recall()
	local p = CLoLPacket(0x007E)
	p.vTable = 0xFA7D20
	p:EncodeF(myHero.networkID)
	p:Encode1(0xFC)
	p:Encode1(0x42)
	p:Encode1(0x42)
	p:Encode1(0x69)
	p:Encode1(0x7F)
	p:Encode1(0xCB)
	p:Encode1(0x6B)
	p:Encode1(0xFA)
	p:Encode1(0x06)
	p:Encode1(0x13)
	p:Encode1(0xB5)
	p:Encode1(0x0E)
	p:Encode1(0x8A)
	p:Encode1(0x3D)
	p:Encode1(0xE4)
	p:Encode1(0x6B)
	p:Encode1(0x8A)
	p:Encode1(0x01)
	p:Encode1(0x60)
	p:Encode1(0x60)
	p:Encode1(0x60)
	p:Encode1(0x60)
	p:Encode1(0x60)
	p:Encode1(0x60)
	p:Encode1(0x60)
	p:Encode1(0x60)
	p:Encode1(0x00)
	p:Encode1(0x20)
	p:Encode1(0x1D)
	p:Encode1(0x07)
 
  SendPacket(p)
end

function move()
	local p = CLoLPacket(0x0101)
	p.vTable = 0xF0E29C
	p:EncodeF(myHero.networkID)
	p:Encode1(0x60)
	p:Encode1(0xE5)
	p:Encode1(0x52)
	p:Encode1(0x06)
	p:Encode1(0x6F)
	p:Encode1(0xE5)
	p:Encode1(0x52)
	p:Encode1(0x06)
	p:Encode1(0x73)
	p:Encode1(0xE5)
	p:Encode1(0x52)
	p:Encode1(0x06)
	p:Encode1(0xA8)
	p:Encode1(0x8C)
	p:Encode1(0x0C)
	p:Encode1(0x01)
	p:Encode1(0x17)
	p:Encode1(0x17)
	p:Encode1(0xC7)
	p:Encode1(0x63)
	p:Encode1(0x17)
	p:Encode1(0xFF)
	p:Encode1(0xCD)
	p:Encode1(0x0F)
	p:Encode1(0x6A)
	p:Encode1(0x6A)
	p:Encode1(0x6A)
	p:Encode1(0x6A)
	p:Encode1(0x31)
	p:Encode1(0x00)
	p:Encode1(0x00)
	p:Encode1(0x00)
	p:Encode1(0x00)

  
  SendPacket(p)
end

function taunt()
	local p = CLoLPacket(0x000F)
	p.vTable = 0xF02A78
	p:EncodeF(myHero.networkID)
	p:Encode1(0xB1)
	p:Encode1(0x07)
	p:Encode1(0xBC)
	p:Encode1(0xEA)
	p:Encode1(0x14)
	SendPacket(p)
end

function laugh()
	local p = CLoLPacket(0x000F)
	p.vTable = 0xF02A78
	p:EncodeF(myHero.networkID)
	p:Encode1(0xF1)
	p:Encode1(0x07)
	p:Encode1(0xBC)
	p:Encode1(0xEA)
	p:Encode1(0x14)
	SendPacket(p)
end

function joke()
	local p = CLoLPacket(0x000F)
	p.vTable = 0xF02A78
	p:EncodeF(myHero.networkID)
	p:Encode1(0x71)
	p:Encode1(0x07)
	p:Encode1(0xBC)
	p:Encode1(0xEA)
	p:Encode1(0x14)
	SendPacket(p)
end

function mastery()
	local p = CLoLPacket(0x003E)
	p.vTable = 0xEC2BC0
	p:EncodeF(myHero.networkID)
	p:Encode1(0x71)
	p:Encode1(0x71)
	p:Encode1(0x71)
	p:Encode1(0x71)
	p:Encode1(0xB6)
	p:Encode1(0x07)
	p:Encode1(0xBC)
	p:Encode1(0xEA)
	SendPacket(p)
end
