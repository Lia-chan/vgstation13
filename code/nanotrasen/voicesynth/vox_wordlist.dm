// VOX word-to-file match list
var/vox_sounds = list(\
"_comma" = 'sound/vox/_comma.ogg',\
"_period" = 'sound/vox/_period.ogg',\
"a" = 'sound/vox/a.ogg',\
"accelerating" = 'sound/vox/accelerating.ogg',\
"accelerator" = 'sound/vox/accelerator.ogg',\
"accepted" = 'sound/vox/accepted.ogg',\
"access" = 'sound/vox/access.ogg',\
"acknowledge" = 'sound/vox/acknowledge.ogg',\
"acknowledged" = 'sound/vox/acknowledged.ogg',\
"acquired" = 'sound/vox/acquired.ogg',\
"acquisition" = 'sound/vox/acquisition.ogg',\
"across" = 'sound/vox/across.ogg',\
"activate" = 'sound/vox/activate.ogg',\
"activated" = 'sound/vox/activated.ogg',\
"activity" = 'sound/vox/activity.ogg',\
"adios" = 'sound/vox/adios.ogg',\
"administration" = 'sound/vox/administration.ogg',\
"advanced" = 'sound/vox/advanced.ogg',\
"after" = 'sound/vox/after.ogg',\
"agent" = 'sound/vox/agent.ogg',\
"alarm" = 'sound/vox/alarm.ogg',\
"alert" = 'sound/vox/alert.ogg',\
"alien" = 'sound/vox/alien.ogg',\
"aligned" = 'sound/vox/aligned.ogg',\
"all" = 'sound/vox/all.ogg',\
"alpha" = 'sound/vox/alpha.ogg',\
"am" = 'sound/vox/am.ogg',\
"amigo" = 'sound/vox/amigo.ogg',\
"ammunition" = 'sound/vox/ammunition.ogg',\
"an" = 'sound/vox/an.ogg',\
"and" = 'sound/vox/and.ogg',\
"announcement" = 'sound/vox/announcement.ogg',\
"anomalous" = 'sound/vox/anomalous.ogg',\
"antenna" = 'sound/vox/antenna.ogg',\
"any" = 'sound/vox/any.ogg',\
"apprehend" = 'sound/vox/apprehend.ogg',\
"approach" = 'sound/vox/approach.ogg',\
"are" = 'sound/vox/are.ogg',\
"area" = 'sound/vox/area.ogg',\
"arm" = 'sound/vox/arm.ogg',\
"armed" = 'sound/vox/armed.ogg',\
"armor" = 'sound/vox/armor.ogg',\
"armory" = 'sound/vox/armory.ogg',\
"arrest" = 'sound/vox/arrest.ogg',\
"ass" = 'sound/vox/ass.ogg',\
"at" = 'sound/vox/at.ogg',\
"atomic" = 'sound/vox/atomic.ogg',\
"attention" = 'sound/vox/attention.ogg',\
"authorize" = 'sound/vox/authorize.ogg',\
"authorized" = 'sound/vox/authorized.ogg',\
"automatic" = 'sound/vox/automatic.ogg',\
"away" = 'sound/vox/away.ogg',\
"b" = 'sound/vox/b.ogg',\
"back" = 'sound/vox/back.ogg',\
"backman" = 'sound/vox/backman.ogg',\
"bad" = 'sound/vox/bad.ogg',\
"bag" = 'sound/vox/bag.ogg',\
"bailey" = 'sound/vox/bailey.ogg',\
"barracks" = 'sound/vox/barracks.ogg',\
"base" = 'sound/vox/base.ogg',\
"bay" = 'sound/vox/bay.ogg',\
"be" = 'sound/vox/be.ogg',\
"been" = 'sound/vox/been.ogg',\
"before" = 'sound/vox/before.ogg',\
"beyond" = 'sound/vox/beyond.ogg',\
"biohazard" = 'sound/vox/biohazard.ogg',\
"biological" = 'sound/vox/biological.ogg',\
"birdwell" = 'sound/vox/birdwell.ogg',\
"bizwarn" = 'sound/vox/bizwarn.ogg',\
"black" = 'sound/vox/black.ogg',\
"blast" = 'sound/vox/blast.ogg',\
"blocked" = 'sound/vox/blocked.ogg',\
"bloop" = 'sound/vox/bloop.ogg',\
"blue" = 'sound/vox/blue.ogg',\
"bottom" = 'sound/vox/bottom.ogg',\
"bravo" = 'sound/vox/bravo.ogg',\
"breach" = 'sound/vox/breach.ogg',\
"breached" = 'sound/vox/breached.ogg',\
"break" = 'sound/vox/break.ogg',\
"bridge" = 'sound/vox/bridge.ogg',\
"bust" = 'sound/vox/bust.ogg',\
"but" = 'sound/vox/but.ogg',\
"button" = 'sound/vox/button.ogg',\
"buzwarn" = 'sound/vox/buzwarn.ogg',\
"bypass" = 'sound/vox/bypass.ogg',\
"c" = 'sound/vox/c.ogg',\
"cable" = 'sound/vox/cable.ogg',\
"call" = 'sound/vox/call.ogg',\
"called" = 'sound/vox/called.ogg',\
"canal" = 'sound/vox/canal.ogg',\
"cap" = 'sound/vox/cap.ogg',\
"captain" = 'sound/vox/captain.ogg',\
"capture" = 'sound/vox/capture.ogg',\
"ceiling" = 'sound/vox/ceiling.ogg',\
"celsius" = 'sound/vox/celsius.ogg',\
"center" = 'sound/vox/center.ogg',\
"centi" = 'sound/vox/centi.ogg',\
"central" = 'sound/vox/central.ogg',\
"chamber" = 'sound/vox/chamber.ogg',\
"charlie" = 'sound/vox/charlie.ogg',\
"check" = 'sound/vox/check.ogg',\
"checkpoint" = 'sound/vox/checkpoint.ogg',\
"chemical" = 'sound/vox/chemical.ogg',\
"cleanup" = 'sound/vox/cleanup.ogg',\
"clear" = 'sound/vox/clear.ogg',\
"clearance" = 'sound/vox/clearance.ogg',\
"close" = 'sound/vox/close.ogg',\
"code" = 'sound/vox/code.ogg',\
"coded" = 'sound/vox/coded.ogg',\
"collider" = 'sound/vox/collider.ogg',\
"command" = 'sound/vox/command.ogg',\
"communication" = 'sound/vox/communication.ogg',\
"complex" = 'sound/vox/complex.ogg',\
"computer" = 'sound/vox/computer.ogg',\
"condition" = 'sound/vox/condition.ogg',\
"containment" = 'sound/vox/containment.ogg',\
"contamination" = 'sound/vox/contamination.ogg',\
"control" = 'sound/vox/control.ogg',\
"coolant" = 'sound/vox/coolant.ogg',\
"coomer" = 'sound/vox/coomer.ogg',\
"core" = 'sound/vox/core.ogg',\
"correct" = 'sound/vox/correct.ogg',\
"corridor" = 'sound/vox/corridor.ogg',\
"crew" = 'sound/vox/crew.ogg',\
"cross" = 'sound/vox/cross.ogg',\
"cryogenic" = 'sound/vox/cryogenic.ogg',\
"d" = 'sound/vox/d.ogg',\
"dadeda" = 'sound/vox/dadeda.ogg',\
"damage" = 'sound/vox/damage.ogg',\
"damaged" = 'sound/vox/damaged.ogg',\
"danger" = 'sound/vox/danger.ogg',\
"day" = 'sound/vox/day.ogg',\
"deactivated" = 'sound/vox/deactivated.ogg',\
"decompression" = 'sound/vox/decompression.ogg',\
"decontamination" = 'sound/vox/decontamination.ogg',\
"deeoo" = 'sound/vox/deeoo.ogg',\
"defense" = 'sound/vox/defense.ogg',\
"degrees" = 'sound/vox/degrees.ogg',\
"delta" = 'sound/vox/delta.ogg',\
"denied" = 'sound/vox/denied.ogg',\
"deploy" = 'sound/vox/deploy.ogg',\
"deployed" = 'sound/vox/deployed.ogg',\
"destroy" = 'sound/vox/destroy.ogg',\
"destroyed" = 'sound/vox/destroyed.ogg',\
"detain" = 'sound/vox/detain.ogg',\
"detected" = 'sound/vox/detected.ogg',\
"detonation" = 'sound/vox/detonation.ogg',\
"device" = 'sound/vox/device.ogg',\
"did" = 'sound/vox/did.ogg',\
"die" = 'sound/vox/die.ogg',\
"dimensional" = 'sound/vox/dimensional.ogg',\
"dirt" = 'sound/vox/dirt.ogg',\
"disengaged" = 'sound/vox/disengaged.ogg',\
"dish" = 'sound/vox/dish.ogg',\
"disposal" = 'sound/vox/disposal.ogg',\
"distance" = 'sound/vox/distance.ogg',\
"distortion" = 'sound/vox/distortion.ogg',\
"do" = 'sound/vox/do.ogg',\
"doctor" = 'sound/vox/doctor.ogg',\
"doop" = 'sound/vox/doop.ogg',\
"door" = 'sound/vox/door.ogg',\
"down" = 'sound/vox/down.ogg',\
"dual" = 'sound/vox/dual.ogg',\
"duct" = 'sound/vox/duct.ogg',\
"e" = 'sound/vox/e.ogg',\
"east" = 'sound/vox/east.ogg',\
"echo" = 'sound/vox/echo.ogg',\
"ed" = 'sound/vox/ed.ogg',\
"effect" = 'sound/vox/effect.ogg',\
"egress" = 'sound/vox/egress.ogg',\
"eight" = 'sound/vox/eight.ogg',\
"eighteen" = 'sound/vox/eighteen.ogg',\
"eighty" = 'sound/vox/eighty.ogg',\
"electric" = 'sound/vox/electric.ogg',\
"electromagnetic" = 'sound/vox/electromagnetic.ogg',\
"elevator" = 'sound/vox/elevator.ogg',\
"eleven" = 'sound/vox/eleven.ogg',\
"eliminate" = 'sound/vox/eliminate.ogg',\
"emergency" = 'sound/vox/emergency.ogg',\
"energy" = 'sound/vox/energy.ogg',\
"engage" = 'sound/vox/engage.ogg',\
"engaged" = 'sound/vox/engaged.ogg',\
"engine" = 'sound/vox/engine.ogg',\
"enter" = 'sound/vox/enter.ogg',\
"entry" = 'sound/vox/entry.ogg',\
"environment" = 'sound/vox/environment.ogg',\
"error" = 'sound/vox/error.ogg',\
"escape" = 'sound/vox/escape.ogg',\
"evacuate" = 'sound/vox/evacuate.ogg',\
"exchange" = 'sound/vox/exchange.ogg',\
"exit" = 'sound/vox/exit.ogg',\
"expect" = 'sound/vox/expect.ogg',\
"experiment" = 'sound/vox/experiment.ogg',\
"experimental" = 'sound/vox/experimental.ogg',\
"explode" = 'sound/vox/explode.ogg',\
"explosion" = 'sound/vox/explosion.ogg',\
"exposure" = 'sound/vox/exposure.ogg',\
"exterminate" = 'sound/vox/exterminate.ogg',\
"extinguish" = 'sound/vox/extinguish.ogg',\
"extinguisher" = 'sound/vox/extinguisher.ogg',\
"extreme" = 'sound/vox/extreme.ogg',\
"f" = 'sound/vox/f.ogg',\
"facility" = 'sound/vox/facility.ogg',\
"fahrenheit" = 'sound/vox/fahrenheit.ogg',\
"failed" = 'sound/vox/failed.ogg',\
"failure" = 'sound/vox/failure.ogg',\
"farthest" = 'sound/vox/farthest.ogg',\
"fast" = 'sound/vox/fast.ogg',\
"feet" = 'sound/vox/feet.ogg',\
"field" = 'sound/vox/field.ogg',\
"fifteen" = 'sound/vox/fifteen.ogg',\
"fifth" = 'sound/vox/fifth.ogg',\
"fifty" = 'sound/vox/fifty.ogg',\
"final" = 'sound/vox/final.ogg',\
"fine" = 'sound/vox/fine.ogg',\
"fire" = 'sound/vox/fire.ogg',\
"first" = 'sound/vox/first.ogg',\
"five" = 'sound/vox/five.ogg',\
"flooding" = 'sound/vox/flooding.ogg',\
"floor" = 'sound/vox/floor.ogg',\
"fool" = 'sound/vox/fool.ogg',\
"for" = 'sound/vox/for.ogg',\
"forbidden" = 'sound/vox/forbidden.ogg',\
"force" = 'sound/vox/force.ogg',\
"forms" = 'sound/vox/forms.ogg',\
"found" = 'sound/vox/found.ogg',\
"four" = 'sound/vox/four.ogg',\
"fourteen" = 'sound/vox/fourteen.ogg',\
"fourth" = 'sound/vox/fourth.ogg',\
"fourty" = 'sound/vox/fourty.ogg',\
"foxtrot" = 'sound/vox/foxtrot.ogg',\
"freeman" = 'sound/vox/freeman.ogg',\
"freezer" = 'sound/vox/freezer.ogg',\
"from" = 'sound/vox/from.ogg',\
"front" = 'sound/vox/front.ogg',\
"fuel" = 'sound/vox/fuel.ogg',\
"g" = 'sound/vox/g.ogg',\
"get" = 'sound/vox/get.ogg',\
"go" = 'sound/vox/go.ogg',\
"going" = 'sound/vox/going.ogg',\
"good" = 'sound/vox/good.ogg',\
"goodbye" = 'sound/vox/goodbye.ogg',\
"gordon" = 'sound/vox/gordon.ogg',\
"got" = 'sound/vox/got.ogg',\
"government" = 'sound/vox/government.ogg',\
"granted" = 'sound/vox/granted.ogg',\
"great" = 'sound/vox/great.ogg',\
"green" = 'sound/vox/green.ogg',\
"grenade" = 'sound/vox/grenade.ogg',\
"guard" = 'sound/vox/guard.ogg',\
"gulf" = 'sound/vox/gulf.ogg',\
"gun" = 'sound/vox/gun.ogg',\
"guthrie" = 'sound/vox/guthrie.ogg',\
"handling" = 'sound/vox/handling.ogg',\
"hangar" = 'sound/vox/hangar.ogg',\
"has" = 'sound/vox/has.ogg',\
"have" = 'sound/vox/have.ogg',\
"hazard" = 'sound/vox/hazard.ogg',\
"head" = 'sound/vox/head.ogg',\
"health" = 'sound/vox/health.ogg',\
"heat" = 'sound/vox/heat.ogg',\
"helicopter" = 'sound/vox/helicopter.ogg',\
"helium" = 'sound/vox/helium.ogg',\
"hello" = 'sound/vox/hello.ogg',\
"help" = 'sound/vox/help.ogg',\
"here" = 'sound/vox/here.ogg',\
"hide" = 'sound/vox/hide.ogg',\
"high" = 'sound/vox/high.ogg',\
"highest" = 'sound/vox/highest.ogg',\
"hit" = 'sound/vox/hit.ogg',\
"hole" = 'sound/vox/hole.ogg',\
"hostile" = 'sound/vox/hostile.ogg',\
"hot" = 'sound/vox/hot.ogg',\
"hotel" = 'sound/vox/hotel.ogg',\
"hour" = 'sound/vox/hour.ogg',\
"hours" = 'sound/vox/hours.ogg',\
"hundred" = 'sound/vox/hundred.ogg',\
"hydro" = 'sound/vox/hydro.ogg',\
"i" = 'sound/vox/i.ogg',\
"idiot" = 'sound/vox/idiot.ogg',\
"illegal" = 'sound/vox/illegal.ogg',\
"immediate" = 'sound/vox/immediate.ogg',\
"immediately" = 'sound/vox/immediately.ogg',\
"in" = 'sound/vox/in.ogg',\
"inches" = 'sound/vox/inches.ogg',\
"india" = 'sound/vox/india.ogg',\
"ing" = 'sound/vox/ing.ogg',\
"inoperative" = 'sound/vox/inoperative.ogg',\
"inside" = 'sound/vox/inside.ogg',\
"inspection" = 'sound/vox/inspection.ogg',\
"inspector" = 'sound/vox/inspector.ogg',\
"interchange" = 'sound/vox/interchange.ogg',\
"intruder" = 'sound/vox/intruder.ogg',\
"invallid" = 'sound/vox/invallid.ogg',\
"invasion" = 'sound/vox/invasion.ogg',\
"is" = 'sound/vox/is.ogg',\
"it" = 'sound/vox/it.ogg',\
"johnson" = 'sound/vox/johnson.ogg',\
"juliet" = 'sound/vox/juliet.ogg',\
"key" = 'sound/vox/key.ogg',\
"kill" = 'sound/vox/kill.ogg',\
"kilo" = 'sound/vox/kilo.ogg',\
"kit" = 'sound/vox/kit.ogg',\
"lab" = 'sound/vox/lab.ogg',\
"lambda" = 'sound/vox/lambda.ogg',\
"laser" = 'sound/vox/laser.ogg',\
"last" = 'sound/vox/last.ogg',\
"launch" = 'sound/vox/launch.ogg',\
"leak" = 'sound/vox/leak.ogg',\
"leave" = 'sound/vox/leave.ogg',\
"left" = 'sound/vox/left.ogg',\
"legal" = 'sound/vox/legal.ogg',\
"level" = 'sound/vox/level.ogg',\
"levels" = 'sound/vox/levels.ogg',\
"lever" = 'sound/vox/lever.ogg',\
"lie" = 'sound/vox/lie.ogg',\
"lieutenant" = 'sound/vox/lieutenant.ogg',\
"life" = 'sound/vox/life.ogg',\
"light" = 'sound/vox/light.ogg',\
"lima" = 'sound/vox/lima.ogg',\
"liquid" = 'sound/vox/liquid.ogg',\
"loading" = 'sound/vox/loading.ogg',\
"locate" = 'sound/vox/locate.ogg',\
"located" = 'sound/vox/located.ogg',\
"location" = 'sound/vox/location.ogg',\
"lock" = 'sound/vox/lock.ogg',\
"locked" = 'sound/vox/locked.ogg',\
"locker" = 'sound/vox/locker.ogg',\
"lockout" = 'sound/vox/lockout.ogg',\
"lower" = 'sound/vox/lower.ogg',\
"lowest" = 'sound/vox/lowest.ogg',\
"magnetic" = 'sound/vox/magnetic.ogg',\
"main" = 'sound/vox/main.ogg',\
"maintenance" = 'sound/vox/maintenance.ogg',\
"malfunction" = 'sound/vox/malfunction.ogg',\
"man" = 'sound/vox/man.ogg',\
"mass" = 'sound/vox/mass.ogg',\
"materials" = 'sound/vox/materials.ogg',\
"maximum" = 'sound/vox/maximum.ogg',\
"may" = 'sound/vox/may.ogg',\
"medical" = 'sound/vox/medical.ogg',\
"men" = 'sound/vox/men.ogg',\
"mercy" = 'sound/vox/mercy.ogg',\
"mesa" = 'sound/vox/mesa.ogg',\
"message" = 'sound/vox/message.ogg',\
"meter" = 'sound/vox/meter.ogg',\
"micro" = 'sound/vox/micro.ogg',\
"middle" = 'sound/vox/middle.ogg',\
"mike" = 'sound/vox/mike.ogg',\
"miles" = 'sound/vox/miles.ogg',\
"military" = 'sound/vox/military.ogg',\
"milli" = 'sound/vox/milli.ogg',\
"million" = 'sound/vox/million.ogg',\
"minefield" = 'sound/vox/minefield.ogg',\
"minimum" = 'sound/vox/minimum.ogg',\
"minutes" = 'sound/vox/minutes.ogg',\
"mister" = 'sound/vox/mister.ogg',\
"mode" = 'sound/vox/mode.ogg',\
"motor" = 'sound/vox/motor.ogg',\
"motorpool" = 'sound/vox/motorpool.ogg',\
"move" = 'sound/vox/move.ogg',\
"must" = 'sound/vox/must.ogg',\
"nearest" = 'sound/vox/nearest.ogg',\
"nice" = 'sound/vox/nice.ogg',\
"nine" = 'sound/vox/nine.ogg',\
"nineteen" = 'sound/vox/nineteen.ogg',\
"ninety" = 'sound/vox/ninety.ogg',\
"no" = 'sound/vox/no.ogg',\
"nominal" = 'sound/vox/nominal.ogg',\
"north" = 'sound/vox/north.ogg',\
"not" = 'sound/vox/not.ogg',\
"november" = 'sound/vox/november.ogg',\
"now" = 'sound/vox/now.ogg',\
"number" = 'sound/vox/number.ogg',\
"objective" = 'sound/vox/objective.ogg',\
"observation" = 'sound/vox/observation.ogg',\
"of" = 'sound/vox/of.ogg',\
"officer" = 'sound/vox/officer.ogg',\
"ok" = 'sound/vox/ok.ogg',\
"on" = 'sound/vox/on.ogg',\
"one" = 'sound/vox/one.ogg',\
"open" = 'sound/vox/open.ogg',\
"operating" = 'sound/vox/operating.ogg',\
"operations" = 'sound/vox/operations.ogg',\
"operative" = 'sound/vox/operative.ogg',\
"option" = 'sound/vox/option.ogg',\
"order" = 'sound/vox/order.ogg',\
"organic" = 'sound/vox/organic.ogg',\
"oscar" = 'sound/vox/oscar.ogg',\
"out" = 'sound/vox/out.ogg',\
"outside" = 'sound/vox/outside.ogg',\
"over" = 'sound/vox/over.ogg',\
"overload" = 'sound/vox/overload.ogg',\
"override" = 'sound/vox/override.ogg',\
"pacify" = 'sound/vox/pacify.ogg',\
"pain" = 'sound/vox/pain.ogg',\
"pal" = 'sound/vox/pal.ogg',\
"panel" = 'sound/vox/panel.ogg',\
"percent" = 'sound/vox/percent.ogg',\
"perimeter" = 'sound/vox/perimeter.ogg',\
"permitted" = 'sound/vox/permitted.ogg',\
"personnel" = 'sound/vox/personnel.ogg',\
"pipe" = 'sound/vox/pipe.ogg',\
"plant" = 'sound/vox/plant.ogg',\
"platform" = 'sound/vox/platform.ogg',\
"please" = 'sound/vox/please.ogg',\
"point" = 'sound/vox/point.ogg',\
"portal" = 'sound/vox/portal.ogg',\
"power" = 'sound/vox/power.ogg',\
"presence" = 'sound/vox/presence.ogg',\
"press" = 'sound/vox/press.ogg',\
"primary" = 'sound/vox/primary.ogg',\
"proceed" = 'sound/vox/proceed.ogg',\
"processing" = 'sound/vox/processing.ogg',\
"progress" = 'sound/vox/progress.ogg',\
"proper" = 'sound/vox/proper.ogg',\
"propulsion" = 'sound/vox/propulsion.ogg',\
"prosecute" = 'sound/vox/prosecute.ogg',\
"protective" = 'sound/vox/protective.ogg',\
"push" = 'sound/vox/push.ogg',\
"quantum" = 'sound/vox/quantum.ogg',\
"quebec" = 'sound/vox/quebec.ogg',\
"question" = 'sound/vox/question.ogg',\
"questioning" = 'sound/vox/questioning.ogg',\
"quick" = 'sound/vox/quick.ogg',\
"quit" = 'sound/vox/quit.ogg',\
"radiation" = 'sound/vox/radiation.ogg',\
"radioactive" = 'sound/vox/radioactive.ogg',\
"rads" = 'sound/vox/rads.ogg',\
"rapid" = 'sound/vox/rapid.ogg',\
"reach" = 'sound/vox/reach.ogg',\
"reached" = 'sound/vox/reached.ogg',\
"reactor" = 'sound/vox/reactor.ogg',\
"red" = 'sound/vox/red.ogg',\
"relay" = 'sound/vox/relay.ogg',\
"released" = 'sound/vox/released.ogg',\
"remaining" = 'sound/vox/remaining.ogg',\
"renegade" = 'sound/vox/renegade.ogg',\
"repair" = 'sound/vox/repair.ogg',\
"report" = 'sound/vox/report.ogg',\
"reports" = 'sound/vox/reports.ogg',\
"required" = 'sound/vox/required.ogg',\
"research" = 'sound/vox/research.ogg',\
"resevoir" = 'sound/vox/resevoir.ogg',\
"resistance" = 'sound/vox/resistance.ogg',\
"right" = 'sound/vox/right.ogg',\
"rocket" = 'sound/vox/rocket.ogg',\
"roger" = 'sound/vox/roger.ogg',\
"romeo" = 'sound/vox/romeo.ogg',\
"room" = 'sound/vox/room.ogg',\
"round" = 'sound/vox/round.ogg',\
"run" = 'sound/vox/run.ogg',\
"safe" = 'sound/vox/safe.ogg',\
"safety" = 'sound/vox/safety.ogg',\
"sargeant" = 'sound/vox/sargeant.ogg',\
"satellite" = 'sound/vox/satellite.ogg',\
"save" = 'sound/vox/save.ogg',\
"science" = 'sound/vox/science.ogg',\
"scream" = 'sound/vox/scream.ogg',\
"screen" = 'sound/vox/screen.ogg',\
"search" = 'sound/vox/search.ogg',\
"second" = 'sound/vox/second.ogg',\
"secondary" = 'sound/vox/secondary.ogg',\
"seconds" = 'sound/vox/seconds.ogg',\
"sector" = 'sound/vox/sector.ogg',\
"secure" = 'sound/vox/secure.ogg',\
"secured" = 'sound/vox/secured.ogg',\
"security" = 'sound/vox/security.ogg',\
"select" = 'sound/vox/select.ogg',\
"selected" = 'sound/vox/selected.ogg',\
"service" = 'sound/vox/service.ogg',\
"seven" = 'sound/vox/seven.ogg',\
"seventeen" = 'sound/vox/seventeen.ogg',\
"seventy" = 'sound/vox/seventy.ogg',\
"severe" = 'sound/vox/severe.ogg',\
"sewage" = 'sound/vox/sewage.ogg',\
"sewer" = 'sound/vox/sewer.ogg',\
"shield" = 'sound/vox/shield.ogg',\
"shipment" = 'sound/vox/shipment.ogg',\
"shock" = 'sound/vox/shock.ogg',\
"shoot" = 'sound/vox/shoot.ogg',\
"shower" = 'sound/vox/shower.ogg',\
"shut" = 'sound/vox/shut.ogg',\
"side" = 'sound/vox/side.ogg',\
"sierra" = 'sound/vox/sierra.ogg',\
"sight" = 'sound/vox/sight.ogg',\
"silo" = 'sound/vox/silo.ogg',\
"six" = 'sound/vox/six.ogg',\
"sixteen" = 'sound/vox/sixteen.ogg',\
"sixty" = 'sound/vox/sixty.ogg',\
"slime" = 'sound/vox/slime.ogg',\
"slow" = 'sound/vox/slow.ogg',\
"soldier" = 'sound/vox/soldier.ogg',\
"some" = 'sound/vox/some.ogg',\
"someone" = 'sound/vox/someone.ogg',\
"something" = 'sound/vox/something.ogg',\
"son" = 'sound/vox/son.ogg',\
"sorry" = 'sound/vox/sorry.ogg',\
"south" = 'sound/vox/south.ogg',\
"squad" = 'sound/vox/squad.ogg',\
"square" = 'sound/vox/square.ogg',\
"stairway" = 'sound/vox/stairway.ogg',\
"status" = 'sound/vox/status.ogg',\
"sterile" = 'sound/vox/sterile.ogg',\
"sterilization" = 'sound/vox/sterilization.ogg',\
"storage" = 'sound/vox/storage.ogg',\
"sub" = 'sound/vox/sub.ogg',\
"subsurface" = 'sound/vox/subsurface.ogg',\
"sudden" = 'sound/vox/sudden.ogg',\
"suit" = 'sound/vox/suit.ogg',\
"superconducting" = 'sound/vox/superconducting.ogg',\
"supercooled" = 'sound/vox/supercooled.ogg',\
"supply" = 'sound/vox/supply.ogg',\
"surface" = 'sound/vox/surface.ogg',\
"surrender" = 'sound/vox/surrender.ogg',\
"surround" = 'sound/vox/surround.ogg',\
"surrounded" = 'sound/vox/surrounded.ogg',\
"switch" = 'sound/vox/switch.ogg',\
"system" = 'sound/vox/system.ogg',\
"systems" = 'sound/vox/systems.ogg',\
"tactical" = 'sound/vox/tactical.ogg',\
"take" = 'sound/vox/take.ogg',\
"talk" = 'sound/vox/talk.ogg',\
"tango" = 'sound/vox/tango.ogg',\
"tank" = 'sound/vox/tank.ogg',\
"target" = 'sound/vox/target.ogg',\
"team" = 'sound/vox/team.ogg',\
"temperature" = 'sound/vox/temperature.ogg',\
"temporal" = 'sound/vox/temporal.ogg',\
"ten" = 'sound/vox/ten.ogg',\
"terminal" = 'sound/vox/terminal.ogg',\
"terminated" = 'sound/vox/terminated.ogg',\
"termination" = 'sound/vox/termination.ogg',\
"test" = 'sound/vox/test.ogg',\
"that" = 'sound/vox/that.ogg',\
"the" = 'sound/vox/the.ogg',\
"then" = 'sound/vox/then.ogg',\
"there" = 'sound/vox/there.ogg',\
"third" = 'sound/vox/third.ogg',\
"thirteen" = 'sound/vox/thirteen.ogg',\
"thirty" = 'sound/vox/thirty.ogg',\
"this" = 'sound/vox/this.ogg',\
"those" = 'sound/vox/those.ogg',\
"thousand" = 'sound/vox/thousand.ogg',\
"threat" = 'sound/vox/threat.ogg',\
"three" = 'sound/vox/three.ogg',\
"through" = 'sound/vox/through.ogg',\
"time" = 'sound/vox/time.ogg',\
"to" = 'sound/vox/to.ogg',\
"top" = 'sound/vox/top.ogg',\
"topside" = 'sound/vox/topside.ogg',\
"touch" = 'sound/vox/touch.ogg',\
"towards" = 'sound/vox/towards.ogg',\
"track" = 'sound/vox/track.ogg',\
"train" = 'sound/vox/train.ogg',\
"transportation" = 'sound/vox/transportation.ogg',\
"truck" = 'sound/vox/truck.ogg',\
"tunnel" = 'sound/vox/tunnel.ogg',\
"turn" = 'sound/vox/turn.ogg',\
"turret" = 'sound/vox/turret.ogg',\
"twelve" = 'sound/vox/twelve.ogg',\
"twenty" = 'sound/vox/twenty.ogg',\
"two" = 'sound/vox/two.ogg',\
"unauthorized" = 'sound/vox/unauthorized.ogg',\
"under" = 'sound/vox/under.ogg',\
"uniform" = 'sound/vox/uniform.ogg',\
"unlocked" = 'sound/vox/unlocked.ogg',\
"until" = 'sound/vox/until.ogg',\
"up" = 'sound/vox/up.ogg',\
"upper" = 'sound/vox/upper.ogg',\
"uranium" = 'sound/vox/uranium.ogg',\
"us" = 'sound/vox/us.ogg',\
"usa" = 'sound/vox/usa.ogg',\
"use" = 'sound/vox/use.ogg',\
"used" = 'sound/vox/used.ogg',\
"user" = 'sound/vox/user.ogg',\
"vacate" = 'sound/vox/vacate.ogg',\
"valid" = 'sound/vox/valid.ogg',\
"vapor" = 'sound/vox/vapor.ogg',\
"vent" = 'sound/vox/vent.ogg',\
"ventillation" = 'sound/vox/ventillation.ogg',\
"victor" = 'sound/vox/victor.ogg',\
"violated" = 'sound/vox/violated.ogg',\
"violation" = 'sound/vox/violation.ogg',\
"voltage" = 'sound/vox/voltage.ogg',\
"vox_login" = 'sound/vox/vox_login.ogg',\
"walk" = 'sound/vox/walk.ogg',\
"wall" = 'sound/vox/wall.ogg',\
"want" = 'sound/vox/want.ogg',\
"wanted" = 'sound/vox/wanted.ogg',\
"warm" = 'sound/vox/warm.ogg',\
"warn" = 'sound/vox/warn.ogg',\
"warning" = 'sound/vox/warning.ogg',\
"waste" = 'sound/vox/waste.ogg',\
"water" = 'sound/vox/water.ogg',\
"we" = 'sound/vox/we.ogg',\
"weapon" = 'sound/vox/weapon.ogg',\
"west" = 'sound/vox/west.ogg',\
"whiskey" = 'sound/vox/whiskey.ogg',\
"white" = 'sound/vox/white.ogg',\
"wilco" = 'sound/vox/wilco.ogg',\
"will" = 'sound/vox/will.ogg',\
"with" = 'sound/vox/with.ogg',\
"without" = 'sound/vox/without.ogg',\
"woop" = 'sound/vox/woop.ogg',\
"xeno" = 'sound/vox/xeno.ogg',\
"yankee" = 'sound/vox/yankee.ogg',\
"yards" = 'sound/vox/yards.ogg',\
"year" = 'sound/vox/year.ogg',\
"yellow" = 'sound/vox/yellow.ogg',\
"yes" = 'sound/vox/yes.ogg',\
"you" = 'sound/vox/you.ogg',\
"your" = 'sound/vox/your.ogg',\
"yourself" = 'sound/vox/yourself.ogg',\
"zero" = 'sound/vox/zero.ogg',\
"zone" = 'sound/vox/zone.ogg',\
"zulu" = 'sound/vox/zulu.ogg')