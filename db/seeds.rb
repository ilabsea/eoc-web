Sop.delete_all

sops = [
  {
    name: 'Type 1 Diabetes',
    tags: 'diabetes autoimmune_disease immune_system beta_cells insulin'
  },
  {
    name: 'Multiple Sclerosis',
    tags: 'Multiple_sclerosis autoimmune_disease myelin nerve_fibers nervous_system.'
  },
  {
    name: 'Crohn\'s & Colitis',
    tags: 'crohn_disease ulcerative_colitis bowel_diseases immune_system intestines'
  },
  {
    name: 'Lupus',
    tags: 'lupus_erythematosus chronic autoimmune_disease body joints skin lungs blood'
  },
  {
    name: 'Rheumatoid Arthritis',
    tags: "rheumatoid_arthritis synovium membrane joints"
  },{
    name: 'Allergies & Asthma',
    tags: "allergies asthma overreacts pollen"
  },
  {
    name: 'Celiac Disease',
    tags: "celiac disease incidence undiagnose health complications"
  },
  {
    name: 'Relapsing Polychondritis',
    tags: "relapsing_polychondritis rheumatic autoimmune_disease cartilage"
  },
  {
    name: 'Liver Disease',
    tags: "viral_infection alcohol environmental_toxins autoimmune_disease genetics"
  },
  {
    name: 'Malaria',
    tags: 'malaria Cambodia phnom_penh'
  },
  {
    name: 'HIV/AIDS',
    tags: 'AIDS female_prostitutes drugs HIV illegal'
  },
  {
    name: 'Dengue Fever',
    tags: "dengue mosquitos rainy_season cambodia"
  },
  {
    name: 'Tuberculosis',
    tags: "tuberculosis Cambodia airborne_infection lungs"
  },
  {
    name: 'Malnutrition',
    tags: 'malnutrition cambodia'
  },
  {
    name: 'Diarrhea diseases',
    tags: "UNICEF die diarrhea diseases annually"
  },
  {
    name: 'Stroke',
    tags: "stroke artery blocked leaks"
  },
  {
    name: 'Lower respiratory infections',
    tags: "lower_respiratory airways lungs."
  },
  {
    name: 'Chronic obstructive pulmonary disease',
    tags: "COPD lung_disease breathing_difficult chronic_bronchitis emphysema"
  },
  {
    name: 'Trachea, bronchus, and lung cancers',
    tags: "respiratory cancers trachea larynx bronchus lungs smoking smoke"
  },
  {
    name: 'Diabetes mellitus',
    tags: "Diabetes diseases insulin pancrease"
  },
  {
    name: 'Dehydration due to diarrheal diseases',
    tags: "Expsr burning cigarette subs"
  },
  {
    name: 'Tuberculosis',
    tags: "Dislocation interphaln joint of finger sequela"
  },
  {
    name: 'Cirrhosis',
    tags: 'Localized enlarged lymph nodes'
  },
  {
    name: 'h5n1',
    tags: "Malignant neoplasm genital organ"
  },
  {
    name: 'ទឹកនោមផ្អែម',
    tags: "ជំងឺ ទឹកនោមផែ្អម អ័រម៉ូន ក្រលៀន"
  },
  {
    name: 'ក្អកមាន់',
    tags: "ក្អក​មាន់ Pertussis whooping cough Coqueluche ក្មេង​តូចៗ"
  },
  {
    name: 'គ្រុនចាញ់',
    tags: "​គ្រុន​ចាញ់ មនុស្ស​គ្រប់​វ័យ ​រដូវ​ក្ដៅ ភ្នាក់​ងារ សត្វ​មូស​ដែក​គោលញី Anophèle"
  },
  {
    name: 'ផ្ដាសាយធម្មតា',
    tags: "ប្រយ័ត្ន​ ​រាង​កាយ ត្រូវ​អាកាសធាតុ​ត្រជាក់ សុខភាព កម្ពុជា"
  },
  {
    name: 'រោគព្រូន',
    tags: 'ព្រូន ​អាច​ចូល​មក ​ក្នុង​ខ្លួន​មនុស្ស​យើង ដផ្លែ​ឈើ បន្លែ​ស្រស់ សាច់​គោ សាច់​ជ្រូក ត្រី​មិន​ស្អាត'
  },
  {
    name: 'រោគមួល',
    tags: 'កម្ពុជា អ្នក​ជំងឺ​ឈឺ​រីងរៃ ​រោគ​ផ្សេងៗ​មក អនាម័យ'
  },
  {
    name: 'សរសៃប្រសាទ',
    tags: '​សរសៃ​ប្រសាទ ចិត្ត​គំនិត​របស់​អ្នក​ជំងឺ ខុស​ប្រក្រតី ត​ពូជ​គ្នា បុព្វជន​ក៏​ថា​បាន'
  },
  {
    name: 'គ្រុន​រលាក​ពោះ​វៀន',
    tags: 'រលាក​ពោះ​វៀន រោគ​នេះ​អាច​កើត​ដល់​ មនុស្ស​គ្រប់​វ័យ ​គ្រប់​ប្រភេទ'
  },
  {
    name: 'ជំងឺហើមសួត',
    tags: 'ហើមសួត មនុស្ស​គ្រប់​វ័យ គ្រប់​ប្រភេទ។'
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
