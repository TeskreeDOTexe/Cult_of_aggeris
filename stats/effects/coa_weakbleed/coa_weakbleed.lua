function init()
  animator.setParticleEmitterOffsetRegion("dripblood", mcontroller.boundBox())
  animator.setParticleEmitterActive("dripblood", true)
  effect.setParentDirectives("fade=BF3300=0.25")
  animator.playSound("bleed", -1)
  
  script.setUpdateDelta(5)

  self.tickDamagePercentage = 0.015
  self.tickTime = 0.5
  self.tickTimer = self.tickTime
end

function update(dt)
  if effect.duration() and world.liquidAt({mcontroller.xPosition(), mcontroller.yPosition() - 1}) then
    effect.expire()
  end

  self.tickTimer = self.tickTimer - dt
  if self.tickTimer <= 0 then
    self.tickTimer = self.tickTime
    status.applySelfDamageRequest({
        damageType = "IgnoresDef",
        damage = math.floor(status.resourceMax("health") * self.tickDamagePercentage) + 1,
        damageSourceKind = "physical",
        sourceEntityId = entity.id()
      })
  end
end

function uninit()
  
end
