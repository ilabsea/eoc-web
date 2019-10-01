# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Sop.delete_all

sops = [
  {
    name: 'Cardioforce',
    tags: 'Lambert-Eaton syndrome in neoplastic disease'
  },
  {
    name: 'Arizona Ash',
    tags: 'Poisoning by unsp general anesthetics, assault, subs encntr'
  },
  {
    name: 'Diovan HCT',
    tags: 'Other displaced fracture of third cervical vertebra'
  },
  {
    name: 'RETROVIR',
    tags: 'Toxic effects of chloroform'
  },
  {
    name: 'Lithium Carbonate',
    tags: "Tuberculosis of nervous system, unspecified"
  },{
    name: 'Treatment Set TS331259',
    tags: "Histoplasmosis capsulati, unspecified"
  },
  {
    name: 'Oxycodone Hydrochloride',
    tags: "Contusion of unsp lesser toe(s) w damage to nail, subs"
  },
  {
    name: 'Valsartan',
    tags: "Child neglect or abandonment, suspected, initial encounter"
  },
  {
    name: 'Everyday Clean Dandruff',
    tags: "Underdosing of drug/meds/biol subst, sequela"
  },
  {
    name: 'Doxycycline Hyclate',
    tags: 'Unspecified sprain of right elbow'
  },
  {
    name: 'FLORIL TEARS',
    tags: 'Other specified joint disorders'
  },
  {
    name: 'Childrens Mucus Relief',
    tags: "Osteonecrosis in diseases classified elsewhere, unsp thigh"
  },
  {
    name: 'Cleocin Phosphate',
    tags: "Pathological fracture in other disease, unsp site, sequela"
  },
  {
    name: 'Prairie Sage',
    tags: 'Unspecified injury of unspecified foot'
  },
  {
    name: 'Hydroxyzine',
    tags: "Subluxation of metacarpophalangeal joint of oth finger, init"
  },
  {
    name: 'CAREALL Tolnaftate',
    tags: "Drown due to fall/jump fr oth burn powered wtrcrft, sequela"
  },
  {
    name: 'Famotidine - Acid Controller',
    tags: "Corrosion of third degree of unsp upper arm, subs encntr"
  },
  {
    name: 'Filbert',
    tags: "Bent bone of unsp ulna, 7thR"
  },
  {
    name: 'In Control Nicotine',
    tags: "Monteggia's fx unsp ulna, 7thE"
  },
  {
    name: 'CALENDULA DIAPER RASH CREAM',
    tags: "Open bite of left ear, sequela"
  },
  {
    name: 'LANEIGE Skin Veil Foundation EX No. 31 Brown Beige',
    tags: "Expsr to oth furniture fire due to burning cigarette, subs"
  },
  {
    name: 'simvastatin',
    tags: "Dislocation of distal interphaln joint of finger, sequela"
  },
  {
    name: 'Lisinopril',
    tags: 'Localized enlarged lymph nodes'
  },
  {
    name: 'Fleet',
    tags: "Malignant neoplasm of female genital organ, unspecified"
  },
  {
    name: 'ibuprofen',
    tags: "Driver of 3-whl mv injured in clsn w oth mv in traf, subs"
  },
  {
    name: 'Loblolly Pine',
    tags: "Unsp fx upper end of l humerus, subs for fx w delay heal"
  },
  {
    name: 'Topiramate',
    tags: "Superficial foreign body of right shoulder, sequela"
  },
  {
    name: 'family wellness childrens ibuprofen',
    tags: "Complete traumatic amp at level betw r hip and knee, sequela"
  },
  {
    name: 'ALPRAZOLAM',
    tags: 'Sltr-haris Type I physl fx upr end rad, l arm, 7thK'
  },
  {
    name: 'DayQuil Severe',
    tags: 'Abrasion of other finger, subsequent encounter'
  },
  {
    name: 'quetiapine fumarate',
    tags: 'Puncture wound w/o foreign body of thumb w/o damage to nail'
  },
  {
    name: 'Zenzedi',
    tags: 'Oth complication of vascular prosth dev/grft, init'
  },
  {
    name: 'Psoriasin',
    tags: 'Nondisp intartic fx l calcaneus, subs for fx w malunion'
  }
]

file = Rails.root.join('public', 'AnimalFarm.pdf')

sops.each do |sop|
  s = Sop.new(sop)
  s.document_type = rand(2)
  if s.document? && File.exist?(file)
    File.open(file) { |f| s.file = f }
  end

  s.save
end
