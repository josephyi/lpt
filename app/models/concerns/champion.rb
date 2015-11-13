module Champion
  extend ActiveSupport::Concern

  TAGS = {
    "poke" => "Because you fancy yourself a sniper",
    "juggernaut" => "Because you're the juggernaut, bitch",
    "mage" => "Because you seem to like shiny particles",
    "fighter" => "Because fisticuffs",
    "tank" => "You seem to love soaking damage",
    "marksman" => "Because CLG needs YOU",
    "support" => "We all know you're the real carry",
    "assassin" => "Strike from shadows!",
    "jungler" => "You just love those trees",
    "duelist" => "Because you like 1v1ing, and winning",
    "hard_cc" => "You take your crowd control seriously",
    "physical_damage" => "Just buy all the swords",
    "magic_damage" => "Spells > swords, right?",
    "true_damage" => "You ignore all their resistances",
    "stealth" => "Sneak sneak sneak",
    "engage" => "We're going now...",
    "disengage" => "You: Nope.",
    "peel" => "Because you like drawing CC toward yourself",
    "knockup" => "You're into champions that play well with Yasuo",
    "burst" => "You believe that death is the best CC",
    "hypercarry" => "Just stall... you carry late",
    "split" => "I have TP",
    "pusher" => "I split, have TP",
    "healer" => "You bring life",
    "triforce" => "You're really good at managing triforce procs",
    "liandrys" => "You like to burn your enemies, slowly.  Sometimes you burn them double",
    "attack_speed" => "You're like pew... pew... pew pew pew pew",
    "energy_based" => "You are a friend of ninjas",
    "mana_based" => "Mage life",
    "health_based" => "You masochist.",
    "rage_based" => "RAWR",
    "cooldown_based" => "You believe resourceless is the way to go",
    "shield" => "You keep your friends alive",
    "dot" => "You enjoy killing your enemies slowly",
    "dash" => "You like that mobility",
    "global" => "You're just everywhere",
    "waveclear" => "You are the ultimate anti seige machine",
    "savior" => "You bring life",
    "death_passive" => "Those death passive baits are pretty effective",
    "dive" => "DIVE DIVE DIVE!",
    "wombo" => "You seem to like those Press R champions (who doesn't?)"
  }

  # Current as of Patch 5.16.1
  CHAMPIONS = {
    "203" => {"name" => "Kindred", "image" => "Kindred.png", "tags" => ["savior", "jungler", "marksman"]},
    "35" => {"name" => "Shaco", "image" => "Shaco.png", "tags" => ["jungler", "assassin"]},
    "36" => {"name" => "Dr. Mundo", "image" => "DrMundo.png", "tags" => ["tank", "health_based", "healer"]},
    "33" => {"name" => "Rammus", "image" => "Rammus.png", "tags" => ["hard_cc", "tank", "jungler"]},
    "34" => {"name" => "Anivia", "image" => "Anivia.png", "tags" => ["liandrys", "hard_cc", "mana_based", "death_passive", "waveclear", "mage"]},
    "39" => {"name" => "Irelia", "image" => "Irelia.png", "tags" => ["triforce", "fighter", "duelist", "split"]},
    "157" => {"name" => "Yasuo", "image" => "Yasuo.png", "tags" => ["knockup", "cooldown_based"]},
    "37" => {"name" => "Sona", "image" => "Sona.png", "tags" => ["mana_based", "shield", "healer", "wombo"]},
    "38" => {"name" => "Kassadin", "image" => "Kassadin.png", "tags" => ["mana_based", "dive", "dash", "shield", "assassin"]},
    "154" => {"name" => "Zac", "image" => "Zac.png", "tags" => ["healer", "health_based", "death_passive", "tank"]},
    "150" => {"name" => "Gnar", "image" => "Gnar.png", "tags" => ["rage_based", "fighter", "hard_cc"]},
    "43" => {"name" => "Karma", "image" => "Karma.png", "tags" => ["shield", "hard_cc", "poke", "disengage"]},
    "42" => {"name" => "Corki", "image" => "Corki.png", "tags" => ["marksman", "dash", "triforce"]},
    "41" => {"name" => "Gangplank", "image" => "Gangplank.png", "tags" => ["triforce", "global", "fighter"]},
    "40" => {"name" => "Janna", "image" => "Janna.png", "tags" => ["support", "shield", "healer", "disengage"]},
    "201" => {"name" => "Braum", "image" => "Braum.png", "tags" => ["support", "peel", "hard_cc", "knockup"]},
    "22" => {"name" => "Ashe", "image" => "Ashe.png", "tags" => ["marksman", "hard_cc", "global"]},
    "23" => {"name" => "Tryndamere", "image" => "Tryndamere.png", "tags" => ["split", "fighter", "rage_based"]},
    "24" => {"name" => "Jax", "image" => "Jax.png", "tags" => ["triforce", "split", "duelist"]},
    "25" => {"name" => "Morgana", "image" => "Morgana.png", "tags" => ["hard_cc", "mage", "shield", "support"]},
    "26" => {"name" => "Zilean", "image" => "Zilean.png", "tags" => ["savior", "mage", "poke", "hard_cc"]},
    "27" => {"name" => "Singed", "image" => "Singed.png", "tags" => ["split", "tank"]},
    "28" => {"name" => "Evelynn", "image" => "Evelynn.png", "tags" => ["stealth", "mage", "jungler"]},
    "29" => {"name" => "Twitch", "image" => "Twitch.png", "tags" => ["marksman", "stealth"]},
    "3" => {"name" => "Galio", "image" => "Galio.png", "tags" => ["hard_cc", "wombo"]},
    "161" => {"name" => "Vel'Koz", "image" => "Velkoz.png", "tags" => ["poke", "liandrys", "mage", "knockup"]},
    "2" => {"name" => "Olaf", "image" => "Olaf.png", "tags" => ["engage", "fighter"]},
    "1" => {"name" => "Annie", "image" => "Annie.png", "tags" => ["mage", "hard_cc", "burst", "engage"]},
    "7" => {"name" => "LeBlanc", "image" => "Leblanc.png", "tags" => ["assassin", "mage", "mana_based"]},
    "30" => {"name" => "Karthus", "image" => "Karthus.png", "tags" => ["death_passive", "mage", "global"]},
    "6" => {"name" => "Urgot", "image" => "Urgot.png", "tags" => ["mana_based", "hard_cc", "knockup"]},
    "32" => {"name" => "Amumu", "image" => "Amumu.png", "tags" => ["tank", "mage", "mana_based", "jungler", "hard_cc"]},
    "5" => {"name" => "Xin Zhao", "image" => "XinZhao.png", "tags" => ["jungler", "knockup", "hard_cc", "dash"]},
    "31" => {"name" => "Cho'gath", "image" => "Chogath.png", "tags" => ["knockup", "hard_cc", "tank", "mage"]},
    "4" => {"name" => "Twisted Fate", "image" => "TwistedFate.png", "tags" => ["mage", "poke", "global"]},
    "9" => {"name" => "Fiddlesticks", "image" => "FiddleSticks.png", "tags" => ["mage", "jungler", "hard_cc"]},
    "8" => {"name" => "Vladimir", "image" => "Vladimir.png", "tags" => ["health_based", "mage"]},
    "19" => {"name" => "Warwick", "image" => "Warwick.png", "tags" => ["hard_cc", "jungler"]},
    "17" => {"name" => "Teemo", "image" => "Teemo.png", "tags" => ["attack_speed", "mage", "pusher"]},
    "18" => {"name" => "Tristana", "image" => "Tristana.png", "tags" => ["pusher", "marksman", "attack_speed", "dash", "knockup"]},
    "15" => {"name" => "Sivir", "image" => "Sivir.png", "tags" => ["shield", "marksman", "waveclear", "engage"]},
    "16" => {"name" => "Soraka", "image" => "Soraka.png", "tags" => ["healer", "global"]},
    "13" => {"name" => "Ryze", "image" => "Ryze.png", "tags" => ["mage", "duelist"]},
    "14" => {"name" => "Sion", "image" => "Sion.png", "tags" => ["tank"]},
    "11" => {"name" => "Master Yi", "image" => "MasterYi.png", "tags" => ["fighter"]},
    "12" => {"name" => "Alistar", "image" => "Alistar.png", "tags" => ["tank", "support", "knockup", "hard_cc"]},
    "21" => {"name" => "Miss Fortune", "image" => "MissFortune.png", "tags" => ["marksman", "wombo"]},
    "20" => {"name" => "Nunu", "image" => "Nunu.png", "tags" => ["wombo", "jungler"]},
    "107" => {"name" => "Rengar", "image" => "Rengar.png", "tags" => ["stealth", "assassin", "jungler"]},
    "106" => {"name" => "Volibear", "image" => "Volibear.png", "tags" => ["jungler", "tank", "engage"]},
    "105" => {"name" => "Fizz", "image" => "Fizz.png", "tags" => ["mage", "assassin", "burst", "knockup"]},
    "104" => {"name" => "Graves", "image" => "Graves.png", "tags" => ["marksman", "burst"]},
    "103" => {"name" => "Ahri", "image" => "Ahri.png", "tags" => ["assassin", "mana_based", "mage", "hard_cc"]},
    "99" => {"name" => "Lux", "image" => "Lux.png", "tags" => ["hard_cc", "mage", "mana_based", "waveclear"]},
    "102" => {"name" => "Shyvana", "image" => "Shyvana.png", "tags" => ["cooldown_based", "fighter"]},
    "101" => {"name" => "Xerath", "image" => "Xerath.png", "tags" => ["mana_based", "mage", "waveclear"]},
    "412" => {"name" => "Thresh", "image" => "Thresh.png", "tags" => ["support", "savior", "knockup"]},
    "98" => {"name" => "Shen", "image" => "Shen.png", "tags" => ["energy_based", "dash", "hard_cc", "tank", "split", "shield"]},
    "222" => {"name" => "Jinx", "image" => "Jinx.png", "tags" => ["marksman", "hard_cc", "global", "hypercarry", "attack_speed"]},
    "96" => {"name" => "Kog'Maw", "image" => "KogMaw.png", "tags" => ["hypercarry", "triforce", "marksman", "poke"]},
    "223" => {"name" => "Tahm Kench", "image" => "TahmKench.png", "tags" => ["savior", "hard_cc", "tank", "support"]},
    "92" => {"name" => "Riven", "image" => "Riven.png", "tags" => ["knockup", "cooldown_based", "fighter", "hard_cc"]},
    "91" => {"name" => "Talon", "image" => "Talon.png", "tags" => ["assassin", "mana_based", "stealth"]},
    "90" => {"name" => "Malzahar", "image" => "Malzahar.png", "tags" => ["mana_based", "mage", "hard_cc", "pusher", "waveclear"]},
    "429" => {"name" => "Kalista", "image" => "Kalista.png", "tags" => ["savior", "marksman", "knockup", "attack_speed"]},
    "10" => {"name" => "Kayle", "image" => "Kayle.png", "tags" => ["savior", "attack_speed", "pusher", "healer"]},
    "421" => {"name" => "Rek'Sai", "image" => "RekSai.png", "tags" => ["jungler", "rage_based"]},
    "89" => {"name" => "Leona", "image" => "Leona.png", "tags" => ["tank", "hard_cc", "engage"]},
    "79" => {"name" => "Gragas", "image" => "Gragas.png", "tags" => ["disengage", "tank", "hard_cc", "engage", "jungler"]},
    "117" => {"name" => "Lulu", "image" => "Lulu.png", "tags" => ["shield", "mana_based", "mage", "support", "knockup"]},
    "114" => {"name" => "Fiora", "image" => "Fiora.png", "tags" => ["duelist", "mana_based"]},
    "78" => {"name" => "Poppy", "image" => "Poppy.png", "tags" => ["hard_cc", "duelist", "triforce", "engage"]},
    "115" => {"name" => "Ziggs", "image" => "Ziggs.png", "tags" => ["poke", "mana_based", "mage", "knockup"]},
    "77" => {"name" => "Udyr", "image" => "Udyr.png", "tags" => ["mana_based", "split", "hard_cc", "triforce"]},
    "112" => {"name" => "Viktor", "image" => "Viktor.png", "tags" => ["waveclear", "mage", "mana_based"]},
    "113" => {"name" => "Sejuani", "image" => "Sejuani.png", "tags" => ["engage", "hard_cc", "jungler"]},
    "110" => {"name" => "Varus", "image" => "Varus.png", "tags" => ["poke", "marksman", "hard_cc"]},
    "111" => {"name" => "Nautilus", "image" => "Nautilus.png", "tags" => ["tank", "hard_cc", "support", "peel", "engage"]},
    "119" => {"name" => "Draven", "image" => "Draven.png", "tags" => ["marksman", "global"]},
    "432" => {"name" => "Bard", "image" => "Bard.png", "tags" => ["savior", "healer", "support"]},
    "245" => {"name" => "Ekko", "image" => "Ekko.png", "tags" => ["dash", "mage", "burst", "assassin"]},
    "82" => {"name" => "Mordekaiser", "image" => "Mordekaiser.png", "tags" => ["juggernaut", "mage"]},
    "83" => {"name" => "Yorick", "image" => "Yorick.png", "tags" => ["fighter", "savior"]},
    "80" => {"name" => "Pantheon", "image" => "Pantheon.png", "tags" => ["hard_cc"]},
    "81" => {"name" => "Ezreal", "image" => "Ezreal.png", "tags" => ["global", "poke", "mana_based", "marksman", "dash"]},
    "86" => {"name" => "Garen", "image" => "Garen.png", "tags" => ["juggernaut", "cooldown_based"]},
    "84" => {"name" => "Akali", "image" => "Akali.png", "tags" => ["energy_based", "assassin", "burst", "stealth"]},
    "85" => {"name" => "Kennen", "image" => "Kennen.png", "tags" => ["hard_cc", "energy_based"]},
    "67" => {"name" => "Vayne", "image" => "Vayne.png", "tags" => ["stealth", "attack_speed", "marksman"]},
    "126" => {"name" => "Jayce", "image" => "Jayce.png", "tags" => ["poke", "fighter", "mana_based"]},
    "69" => {"name" => "Cassiopeia", "image" => "Cassiopeia.png", "tags" => ["liandrys", "mage", "hypercarry", "hard_cc", "mana_based"]},
    "127" => {"name" => "Lissandra", "image" => "Lissandra.png", "tags" => ["hard_cc", "dash", "mana_based"]},
    "68" => {"name" => "Rumble", "image" => "Rumble.png", "tags" => ["cooldown_based", "mage", "liandrys"]},
    "121" => {"name" => "Kha'Zix", "image" => "Khazix.png", "tags" => ["stealth", "assassin", "jungler", "mana_based"]},
    "122" => {"name" => "Darius", "image" => "Darius.png", "tags" => ["juggernaut", "wombo"]},
    "120" => {"name" => "Hecarim", "image" => "Hecarim.png", "tags" => ["triforce", "jungler", "dash", "engage"]},
    "72" => {"name" => "Skarner", "image" => "Skarner.png", "tags" => ["hard_cc", "jungler", "engage"]},
    "236" => {"name" => "Lucian", "image" => "Lucian.png", "tags" => ["marksman", "dash"]},
    "74" => {"name" => "Heimerdinger", "image" => "Heimerdinger.png", "tags" => ["mage", "mana_based", "hard_cc", "waveclear"]},
    "75" => {"name" => "Nasus", "image" => "Nasus.png", "tags" => ["pusher", "hypercarry", "split", "triforce"]},
    "238" => {"name" => "Zed", "image" => "Zed.png", "tags" => ["assassin", "energy_based"]},
    "76" => {"name" => "Nidalee", "image" => "Nidalee.png", "tags" => ["poke", "split", "mana_based", "mage"]},
    "134" => {"name" => "Syndra", "image" => "Syndra.png", "tags" => ["hard_cc", "mana_based", "burst"]},
    "133" => {"name" => "Quinn", "image" => "Quinn.png", "tags" => ["duelist", "marksman", "attack_speed"]},
    "59" => {"name" => "Jarvan IV", "image" => "JarvanIV.png", "tags" => ["wombo", "engage", "knockup"]},
    "58" => {"name" => "Renekton", "image" => "Renekton.png", "tags" => ["fighter", "hard_cc", "rage_based"]},
    "57" => {"name" => "Maokai", "image" => "Maokai.png", "tags" => ["tank", "engage", "peel"]},
    "56" => {"name" => "Nocturne", "image" => "Nocturne.png", "tags" => ["engage", "assassin"]},
    "55" => {"name" => "Katarina", "image" => "Katarina.png", "tags" => ["cooldown_based", "mage"]},
    "64" => {"name" => "Lee Sin", "image" => "LeeSin.png", "tags" => ["jungler", "fighter", "engage"]},
    "62" => {"name" => "Wukong", "image" => "MonkeyKing.png", "tags" => ["engage", "hard_cc", "fighter"]},
    "63" => {"name" => "Brand", "image" => "Brand.png", "tags" => ["liandrys", "hard_cc", "wombo", "mage", "mana_based"]},
    "268" => {"name" => "Azir", "image" => "Azir.png", "tags" => ["attack_speed", "mage", "mana_based", "disengage"]},
    "267" => {"name" => "Nami", "image" => "Nami.png", "tags" => ["disengage", "engage", "healer"]},
    "60" => {"name" => "Elise", "image" => "Elise.png", "tags" => ["engage", "mana_based", "jungler"]},
    "131" => {"name" => "Diana", "image" => "Diana.png", "tags" => ["assassin", "attack_speed", "engage"]},
    "61" => {"name" => "Orianna", "image" => "Orianna.png", "tags" => ["wombo", "mage", "mana_based", "knockup"]},
    "266" => {"name" => "Aatrox", "image" => "Aatrox.png", "tags" => ["death_passive", "split"]},
    "143" => {"name" => "Zyra", "image" => "Zyra.png", "tags" => ["liandrys", "hard_cc", "wombo"]},
    "48" => {"name" => "Trundle", "image" => "Trundle.png", "tags" => ["fighter"]},
    "45" => {"name" => "Veigar", "image" => "Veigar.png", "tags" => ["burst", "mage", "hard_cc"]},
    "44" => {"name" => "Taric", "image" => "Taric.png", "tags" => ["hard_cc", "tank", "peel"]},
    "51" => {"name" => "Caitlyn", "image" => "Caitlyn.png", "tags" => ["marksman", "attack_speed", "pusher"]},
    "53" => {"name" => "Blitzcrank", "image" => "Blitzcrank.png", "tags" => ["engage", "support", "hard_cc", "knockup"]},
    "54" => {"name" => "Malphite", "image" => "Malphite.png", "tags" => ["engage", "knockup", "hard_cc", "tank", "mana_based"]},
    "254" => {"name" => "Vi", "image" => "Vi.png", "tags" => ["engage", "fighter", "knockup"]},
    "50" => {"name" => "Swain", "image" => "Swain.png", "tags" => ["mage", "mana_based", "dot", "hard_cc", "liandrys"]}
  }

  module ClassMethods
    def champion_name_for_id(champion_id)
      CHAMPIONS[champion_id]["name"]
    end

    def champion_image_for_id(champion_id)
      CHAMPIONS[champion_id]["image"]
    end

    def champion_tags_for_id(champion_id)
      CHAMPIONS[champion_id]["tags"]
    end

    def tags
      TAGS.keys
    end

    def tag_phrase_for_tag(tag)
      TAGS[tag]
    end

    def champions
      CHAMPIONS.keys
    end
  end
end
