local m=100100039
local cm=_G["c"..m]
cm.name="地缚灵的引诱"
function cm.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetCondition(cm.condition)
	e1:SetTarget(cm.target)
	e1:SetOperation(cm.activate)
	c:RegisterEffect(e1)
end
--Activate
function cm.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker():IsControler(1-tp)
end
function cm.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local ag,da=Duel.GetAttacker():GetAttackableTarget()
		local at=Duel.GetAttackTarget()
		return ag:IsExists(aux.TRUE,1,at) or (at~=nil and da)
	end
end
function cm.activate(e,tp,eg,ep,ev,re,r,rp)
	local ag,da=Duel.GetAttacker():GetAttackableTarget()
	local at=Duel.GetAttackTarget()
	if da and at~=nil then
		local sel=0
		Duel.Hint(HINT_SELECTMSG,tp,31)
		if ag:IsExists(aux.TRUE,1,at) then
			sel=Duel.SelectOption(tp,1213,1214)
		else
			sel=Duel.SelectOption(tp,1213)
		end
		if sel==0 then
			Duel.ChangeAttackTarget(nil)
			return
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATTACKTARGET)
	local g=ag:Select(tp,1,1,at)
	local tc=g:GetFirst()
	if tc then
		Duel.ChangeAttackTarget(tc)
	end
end