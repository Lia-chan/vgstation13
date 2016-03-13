obj/machinery/atmospherics/pipe
	tank
		highcap
			carbon_dioxide
				name = "High Capacity Pressure Tank (Carbon Dioxide)"

				New()
					air_temporary = new
					air_temporary.volume = volume
					air_temporary.temperature = T20C

					air_temporary.carbon_dioxide = (160*ONE_ATMOSPHERE)*(air_temporary.volume)/(R_IDEAL_GAS_EQUATION*air_temporary.temperature)

					..()

			toxins
				icon = 'orange_pipe_tank.dmi'
				name = "High Capacity Pressure Tank (Plasma)"

				New()
					air_temporary = new
					air_temporary.volume = volume
					air_temporary.temperature = T20C

					air_temporary.toxins = (160*ONE_ATMOSPHERE)*(air_temporary.volume)/(R_IDEAL_GAS_EQUATION*air_temporary.temperature)

					..()

			oxygen
				icon = 'blue_pipe_tank.dmi'
				name = "High Capacity Pressure Tank (Oxygen)"

				New()
					air_temporary = new
					air_temporary.volume = volume
					air_temporary.temperature = T20C

					air_temporary.oxygen = (160*ONE_ATMOSPHERE)*(air_temporary.volume)/(R_IDEAL_GAS_EQUATION*air_temporary.temperature)

					..()

			nitrogen
				icon = 'red_pipe_tank.dmi'
				name = "High Capacity Pressure Tank (Nitrogen)"

				New()
					air_temporary = new
					air_temporary.volume = volume
					air_temporary.temperature = T20C

					air_temporary.nitrogen = (160*ONE_ATMOSPHERE)*(air_temporary.volume)/(R_IDEAL_GAS_EQUATION*air_temporary.temperature)

					..()

			air
				icon = 'red_pipe_tank.dmi'
				name = "High Capacity Pressure Tank (Air)"

				New()
					air_temporary = new
					air_temporary.volume = volume
					air_temporary.temperature = T20C

					air_temporary.oxygen = (160*ONE_ATMOSPHERE*O2STANDARD)*(air_temporary.volume)/(R_IDEAL_GAS_EQUATION*air_temporary.temperature)
					air_temporary.nitrogen = (160*ONE_ATMOSPHERE*N2STANDARD)*(air_temporary.volume)/(R_IDEAL_GAS_EQUATION*air_temporary.temperature)

					..()

			n2o
				icon = 'n2o_pipe_tank.dmi'
				name = "High Capacity Pressure Tank (N2O)"

				New()
					air_temporary = new
					air_temporary.volume = volume
					air_temporary.temperature = T0C

					var/datum/gas/sleeping_agent/trace_gas = new
					trace_gas.moles = (160*ONE_ATMOSPHERE)*(air_temporary.volume)/(R_IDEAL_GAS_EQUATION*air_temporary.temperature)

					air_temporary.trace_gases += trace_gas

					..()