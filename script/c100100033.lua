local m=100100033
local cm=_G["c"..m]
cm.name="魔将 雅灭鲁拉"
function cm.initial_effect(c)
	--Flag
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetOperation(cm.regflag)
	c:RegisterEffect(e1)
	--Cannot Summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(m,0))
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(cm.condition)
	e2:SetCost(cm.cost)
	e2:SetOperation(cm.operation)
	c:RegisterEffect(e2)
end
--Flag
function cm.regflag(e,tp,eg,ep,ev,re,r,rp)
	e:GetHandler():RegisterFlagEffect(m,RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END,0,1)
end
--Special Summon
function cm.condition(e)
	return e:GetHandler():GetFlagEffect(m)~=0
end
function cm.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsCanChangePosition() end
	Duel.ChangePosition(e:GetHandler(),POS_FACEUP_DEFENSE,POS_FACEDOWN_DEFENSE,POS_FACEUP_ATTACK,POS_FACEUP_ATTACK)
end
function cm.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetDescription(aux.Stringid(m,1))
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_CANNOT_SUMMON)
		e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CLIENT_HINT)
		e1:SetRange(LOCATION_MZONE)
		e1:SetTargetRange(1,1)
		e1:SetTarget(cm.sumlimit)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_DISABLE+RESET_PHASE+PHASE_END+RESET_OPPO_TURN)
		c:RegisterEffect(e1)
		local e2=e1:Clone()
		e2:SetDescription(aux.Stringid(m,2))
		e2:SetCode(EFFECT_CANNOT_MSET)
		c:RegisterEffect(e2)
	end
end
function cm.sumlimit(e,c,sump,sumtype,sumpos,targetp,se)
	return c:IsLevelAbove(7) and sumtype==SUMMON_TYPE_ADVANCE
end