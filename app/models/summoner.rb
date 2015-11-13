class Summoner < ActiveRecord::Base
  include Champion

  has_many :champion_stats, dependent: :destroy
  has_many :events, dependent: :destroy

  def process
    response = {}
    response['name'] = self.name
    response['icon'] = self.profile_icon_id
    response['level'] = self.summoner_level
    response['region'] = self.region

    total_games, most_mastered, top_champs, rec_champs, rec_new_champs, all_champs = self.calculate_metrics

    response['total_games'] = total_games
    response['most_mastered'] = most_mastered
    response['top_champs'] = top_champs
    response['champion_stats'] = all_champs
    response['rec_champs'] = rec_champs
    response['rec_new_champs'] = rec_new_champs

    response
  end

  def calculate_metrics
    @stats = self.champion_stats

    most_mastered_champ = ""
    most_mastered_image = ""
    most_mastered_points = 0

    all_champs = {}

    # Scrub nils in painfully hardcoded way
    @stats.each do |champ|
      if champ.total_neutral_minions_killed.nil?
        champ.total_neutral_minions_killed = 0
        champ.save
      end
    end

    total_games = 0.0
    total_mastery = 0.0 # placeholder until total mastery points endpoint is integrated
    @stats.each do |champ|
      if champ.champion_id == 0
        next
      else
        total_games += champ.total_sessions_played
        total_mastery += champ.champion_points
      end
    end

    # Loop only once!
    @stats.each do |champ|
      if champ.champion_id == 0
        next
      end

      # Most Mastered Champ
      if champ.champion_points > most_mastered_points
        most_mastered_champ = Summoner.champion_name_for_id(champ.champion_id.to_s)
        most_mastered_image = Summoner.champion_image_for_id(champ.champion_id.to_s)
        most_mastered_points = champ.champion_points
      end

      # All Champ Data
      current_champ = {
        'id' => champ.champion_id,
        'name' => Summoner.champion_name_for_id(champ.champion_id.to_s),
        'image' => Summoner.champion_image_for_id(champ.champion_id.to_s),
        'tagline' => 'placeholder',
        'mastery_points' => champ.champion_points,
        'kills' => champ.total_champion_kills,
        'assists' => champ.total_assists,
        'deaths' => champ.total_deaths_per_session,
        'cs' => champ.total_minion_kills + champ.total_neutral_minions_killed,
        'gold' => champ.total_gold_earned,
        'games' => champ.total_sessions_played,
        'wins' => champ.total_sessions_won,
        'losses' => champ.total_sessions_lost,
        'ranked_play_ratio' => champ.total_sessions_played / total_games,
        'play_rate' => calculate_play_rate(champ, total_games, total_mastery),
        'performance' => calculate_performance(champ, total_games, total_mastery)
      }

      all_champs[champ.champion_id] = current_champ

    end

    most_mastered = {
      'name' => most_mastered_champ,
      'image' => most_mastered_image,
      'mastery_points' => most_mastered_points
    }

    # Extract top champions
    top_champs = {}
    top_champs['most_practiced'] = (all_champs.max_by { |enum, champ| champ['play_rate'] })[1]
    top_performance = all_champs.find_all { |enum, champ| champ['games'] >= 5 }
    top_performance = top_performance.max_by(2) { |enum, champ| champ['performance'] }
    top_champs['best_performance'] = top_performance[0][1]
    top_champs['second_best_performance'] = top_performance[1][1]

    # Extract recommended champions
    rec_champs = calculate_rec_champs(all_champs)

    # Assemble player characteristic vector and compare to champs to get new recommended champions
    rec_new_champs = calculate_rec_new_champs(all_champs)

    [total_games, most_mastered, top_champs, rec_champs, rec_new_champs, all_champs]
  end

  def calculate_play_rate(champ, total_games, total_mastery)
    game_play_rate = champ.total_sessions_played.to_f / total_games
    mastery_play_rate = champ.champion_points.to_f / total_mastery

    play_rate = game_play_rate * mastery_play_rate * 10000
  end

  def calculate_performance(champ, total_games, total_mastery)
    game_performance = champ.total_sessions_won.to_f / champ.total_sessions_played
    if champ.total_deaths_per_session
      kda_performance = (champ.total_champion_kills + (champ.total_assists / 2.0)) / champ.total_deaths_per_session
    else
      kda_performance = (champ.total_champion_kills + (champ.total_assists / 2.0)) / 0.1
    end

    performance = game_performance * kda_performance
  end

  def calculate_rec_champs(all_champs)
    average_games = 0.0
    average_performance = 0.0
    all_champs.each do |enum, champ|
      average_games += champ['games']
      average_performance += champ['performance'] * champ['games']
    end
    average_performance /= average_games
    average_games /= all_champs.length

    underplayed_champs = all_champs.find_all { |enum, champ| champ['games'] <= average_games }
    underplayed_champs = underplayed_champs.find_all { |enum, champ| champ['performance'] >= average_performance }
    underplayed_champs = underplayed_champs.max_by(2) { |enum, champ| champ['performance'] }
    underplayed_champs.reverse!

    overplayed_champs = all_champs.find_all { |enum, champ| champ['games'] >= average_games }
    overplayed_champs = overplayed_champs.find_all { |enum, champ| champ['performance'] <= average_performance }
    overplayed_champs = overplayed_champs.min_by(1) { |enum, champ| champ['performance'] }
    overplayed_champs.reverse!

    best_champs = all_champs.find_all { |enum, champ| champ['games'] >= average_games }
    best_champs = best_champs.find_all { |enum, champ| champ['performance'] >= average_performance }
    best_champs = best_champs.max_by(2) { |enum, champ| champ['performance'] }
    best_champs.reverse!

    fallback_champs = all_champs.find_all { |enum, champ| champ['games'] >= 5 }
    fallback_champs = fallback_champs.max_by(3) { |enum, champ| champ['performance'] }
    fallback_champs.reverse!

    super_fallback_champs = all_champs.max_by(3) { |enum, champ| champ['performance'] }
    super_fallback_champs.reverse!

    super_fallback_champs.each do |enum, champ|
      champ['label'] = 'new'
    end

    fallback_champs.each do |enum, champ|
      champ['label'] = 'wellplayed'
    end

    best_champs.each do |enum, champ|
      champ['label'] = 'best'
    end

    overplayed_champs.each do |enum, champ|
      champ['label'] = 'overplayed'
    end

    underplayed_champs.each do |enum, champ|
      champ['label'] = 'underplayed'
    end

    rec_champs = []
    3.times do |rec|
      if underplayed_champs.length > 0
        rec_champs.push(underplayed_champs.pop)
      elsif overplayed_champs.length > 0
        rec_champs.push(overplayed_champs.pop)
      elsif best_champs.length > 0
        rec_champs.push(best_champs.pop)
      elsif fallback_champs > 0
        rec_champs.push(fallback_champs.pop)
      else
        rec_champs.push(super_fallback_champs.pop)
      end
    end

    rec_champs.map! { |champ| champ[1] }
    rec_champs
  end

  def calculate_rec_new_champs(all_champs)
    # Characterize the player
    tags = Summoner.tags
    champions = Summoner.champions
    player = Array.new(tags.length, 0.0)
    player_champions = Array.new(all_champs.length, 0.0)

    all_champs.each do |enum, champ|
      player_champions.push(champ['id'].to_s)
      champ_tags = Summoner.champion_tags_for_id(champ['id'].to_s)
      champ_tags.each do |tag|
        player[tags.index(tag)] += champ['games']
      end
    end

    player = normalize_vector(player)

    # Compare to champions they don't own
    champ_similarities = []
    champions.each do |champ|
      champ_tag_vector = Array.new(tags.length, 0.0)
      if !player_champions.include?(champ)
        champ_tags = Summoner.champion_tags_for_id(champ)
        champ_tags.each do |tag|
          champ_tag_vector[tags.index(tag)] += 1
        end
        champ_tag_vector = normalize_vector(champ_tag_vector)

        similarity = dotproduct(player, champ_tag_vector)
        labels = label_vector(tags, champ_tag_vector)
        champ_similarities.push([champ, similarity, labels])
      end
    end

    recs = champ_similarities.max_by(3) { |champ| champ[1] }

    rec_new_champs = []
    recs.each do |rec|
      rec_champ = {
        'id' => rec[0],
        'similarity' => rec[1],
        'name' => Summoner.champion_name_for_id(rec[0]),
        'image' => Summoner.champion_image_for_id(rec[0]),
        'labels' => rec[2]
      }
      rec_new_champs.push(rec_champ)
    end

    rec_new_champs
  end

  def normalize_vector(vect)
    euclength_raw = 0.0
    vect.each { |ele| euclength_raw += ele**2 }
    euclength = Math.sqrt(euclength_raw)

    if euclength <= 0.0
      return vect
    else
      return vect.map { |ele| ele = ele/euclength }
    end
  end

  def dotproduct(vect1, vect2)
    size = vect1.length
    sum = 0.0
    i = 0
    while i < size
      sum += vect1[i] * vect2[i]
      i += 1
    end
    sum
  end

  def label_vector(ref, vect)
    label_count = 2

    # Protect the input vector
    vector = vect.dup

    labels = Array.new()

    label_count.times do
      vectmax = vector.each_with_index.max
      if vectmax[0] > 0
        i = vectmax[1]

        labels.push(ref[i])

        vector[i] = 0
      else
        break
      end
    end

    labels.each do |label|
      label = Summoner.tag_phrase_for_tag(label)
    end

    labels
  end
end
