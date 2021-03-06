# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# (1..100).to_a.each do |i|

#   user = User.create(
#     email: "user#{i}@email.email", password: "asdasdasd", first_name: "Nome #{i}", last_name: "Cognome #{i}"
#   )

#   Topic.all.sample(25).each do |topic|
#     k = topic.known_topic user
#     k.update knowledge: KnownTopic::KNOWLEDGES.sample
#   end
# end

# User.where(email: "carlo.martinucci@gmail.com").first_or_initialize.update(
#   password: "trovarelatori", first_name: "Carlo", last_name: "Martinucci", admin: true, phone: "3391326366",
#   gender: "male", city: "Padova", public_phone: false, public_email: true, public_city: true, public_birthday: false
# )
# User.where(email: 'costanza.albe@gmail.com').first_or_initialize.update(
#   password: 'trovarelatori',
#   first_name: 'Costanza',
#   last_name: 'Albè',
#   gender: 'female',
#   city: 'Padova',
#   public_phone: false,
#   public_email: true,
#   public_city: true,
#   public_birthday: false
# )

[
  ['Bioetica', [
    'Aborto',
    'Charlie Gard',
    'Dat',
    'Droga',
    'Eutanasia',
    'Famiglia',
    'Gender',
    'Dottrina Sociale',
    'Obiezione Di Coscienza'
  ]],

  ['Spiritualità', [
    'Chiesa',
    'Angelus',
    'Fatima',
    'Papa Francesco',
    'Alfonso Maria De Liguori',
    'Cristianesimo orientale',
    'Pollien, François',
    'Teresa Benedetta della Croce, Santa'
  ]],

  ['Diritto', [
    'Diritti',
    'Charlie Gard',
    'Dat',
    'Droga',
    'Eutanasia',
    'Famiglia',
    'Gender',
    'Dottrina Sociale'
  ]],

  ['Via Pulchritudinis', [
    'Arte',
    'Bellezza',
    'Dottrina Sociale'
  ]],

  ['Associazioni', [
    'CDNF',
    'Centro Studi Livatino'
  ]],

  ['Libertà religiosa', [
    'Cristiani Perseguitati',
    'Dottrina Sociale'
  ]],

  ['Economia', [
    'Dottrina Sociale',
    'Estero',
    'Geopolitica',
    'Immigrazione',
    'Italia'
  ]],

  ['Islam', [
    'Dottrina Sociale',
    'ISIS'
  ]],

  ['Storia', [
    'Massoneria',
    'Muro Di Berlino',
    'Referendum Costituzionale',
    'Venezuela',
    'Vienna, Battaglia di ',
    'Viva Maria',
    'Antiproibizionismo',
    'Bisanzio',
    'Brigantaggio',
    'Camorra',
    'Carlismo',
    "Carlo d'Austria",
    "Carlo V d'Asburgo",
    'Civiltà Cattolica',
    'Comitati civici',
    'Cristeros messicani',
    'Crociata spagnola',
    'Fabianesimo',
    'Giubileo',
    'Grande Guerra e Rivoluzione',
    'Illuminismo',
    'Inquisizione',
    'Insorgenze',
    'Libano guerra',
    'Martiri spagnoli',
    'Movimento cattolico in Italia',
    'Movimento nazionalista',
    'Partito moderno',
    'Portogallo missionario',
    'Questione del Mezzogiorno',
    'Questione Romana',
    'Reconquista',
    'Resistenza tedesca al Nazionalsocialismo',
    'Restaurazione',
    'Riconquista cristiana',
    'Russa, guerra civile',
    'Sanfedismo',
    'Scoperta America',
    'Sessantotto italiano',
    "Stati indipendenti d'Italia",
    'Stato Pontificio',
    'Terrore',
    'Tirolo',
    'Vandea'
  ]],

  ['Politica', %w[
    Venezuela
    Trump
    UE
    USA
  ]],

  ['Autori Controrivoluzionari', [
    'Giovanni Cantoni',
    'Belloc, Hilaire ',
    'Bourget, Paul ',
    'Burke, Edmund ',
    'Calvet, dom Gérard',
    'Corrêa de Oliveira, Plinio ',
    'Delp S.J., Alfred',
    'Kirk Russell Amos',
    'Leopardi, Monaldo',
    'Luigi Maria Grignion da Montfort',
    'Cauchy, Augustin-Louis',
    'Dawson, Christopher',
    'Lanteri ',
    'Rosmini Serbati, Beato Antonio'
  ]],

  ['Psicologia', [
    'Frankl, Viktor',
    'Freud, Sigmund',
    'Antipsichiatria',
    'Jung, Gustav'
  ]]
].each do |theme_name, topic_names|
  theme = Theme.where(name: theme_name).first_or_create
  topic_names.each do |topic_name|
    topic = Topic.where(theme_id: theme.id, name: topic_name).first_or_create
    topic.update_keywords true
    sleep 0.5
  end
end
