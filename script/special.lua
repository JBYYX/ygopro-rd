
RushDuel={}

function Auxiliary.PreloadUds()
	--Draw
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_DRAW_COUNT)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetTargetRange(1,1)
	e2:SetValue(RushDuel.draw)
	Duel.RegisterEffect(e2,0)
	--Hand Limit
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_HAND_LIMIT)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,1)
	e3:SetValue(100)
	Duel.RegisterEffect(e3,0)
	--Summon Limit
	local e4=Effect.GlobalEffect()
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_SET_SUMMON_COUNT_LIMIT)
	e4:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e4:SetTargetRange(1,1)
	e4:SetValue(100)
	Duel.RegisterEffect(e4,0)
	--Lock Zone
	local e5=Effect.GlobalEffect()
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_DISABLE_FIELD)
	e5:SetOperation(RushDuel.lockzone)
	Duel.RegisterEffect(e5,0)
	--Skip M2
	local e6=Effect.GlobalEffect()
	e6:SetType(EFFECT_TYPE_FIELD)
	e6:SetCode(EFFECT_SKIP_M2)
	e6:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e6:SetTargetRange(1,1)
	Duel.RegisterEffect(e6,0)
	--Trap Chain
	local e7=Effect.GlobalEffect()
	e7:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e7:SetCode(EVENT_CHAINING)
	e7:SetOperation(RushDuel.chainop)
	Duel.RegisterEffect(e7,0)
end
function RushDuel.draw(e)
	local p=Duel.GetTurnPlayer()
	local ct=Duel.GetFieldGroupCount(p,LOCATION_HAND,0)
	if ct>4 then return 1
	else return 5-ct end
end
--Lock Zone
function RushDuel.lockzone(e,tp)
	return 0x11111111
end
--Trap Chain
function RushDuel.chainop(e,tp,eg,ep,ev,re,r,rp)
	local time=re:GetCode()
	if re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_TRAP) and time~=EVENT_CHAINING then
		Duel.SetChainLimit(chaintime(time))
	end
end
function RushDuel.chaintime(code)
	return  function(e,rp,tp)
				return not (e:IsHasType(EFFECT_TYPE_ACTIVATE) and e:IsActiveType(TYPE_TRAP) and e:GetCode()==code) 
			end
end
