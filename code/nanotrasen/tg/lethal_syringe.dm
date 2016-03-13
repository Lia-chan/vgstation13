/obj/item/weapon/reagent_containers/syringe/lethal
        name = "lethal injection syringe"
        desc = "A syringe used for lethal injections. It can hold up to 50 units."
        amount_per_transfer_from_this = 50
        volume = 50

/obj/item/weapon/reagent_containers/syringe/lethal/choral
        New()
                ..()
                reagents.add_reagent("chloralhydrate", 50)
                mode = SYRINGE_INJECT
                update_icon()