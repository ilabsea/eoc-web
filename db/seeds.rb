Sop.delete_all

def file_exist? file
  file.present? && File.exist?(file)
end

sops = [
  {
    name: 'Type 1 Diabetes',
    document_type: 0,
    file: '1.jpg',
    tags: 'diabetes autoimmune_disease immune_system beta_cells insulin'
  },
  {
    name: 'Multiple Sclerosis',
    document_type: 1,
    file: nil,
    tags: 'Multiple_sclerosis autoimmune_disease myelin nerve_fibers nervous_system.'
  },
  {
    name: 'Crohn\'s & Colitis',
    document_type: 0,
    file: '2.jpg',
    tags: 'crohn_disease ulcerative_colitis bowel_diseases immune_system intestines'
  },
  {
    name: 'Lupus',
    document_type: 0,
    file: '2.jpg',
    tags: 'lupus_erythematosus chronic autoimmune_disease body joints skin lungs blood'
  },
  {
    name: 'Rheumatoid Arthritis',
    document_type: 1,
    file: nil,
    tags: "rheumatoid_arthritis synovium membrane joints"
  },{
    name: 'Allergies & Asthma',
    document_type: 0,
    file: '3.jpg',
    tags: "allergies asthma overreacts pollen"
  },
  {
    name: 'Celiac Disease',
    document_type: 0,
    file: '2.jpg',
    tags: "celiac disease incidence undiagnose health complications"
  },
  {
    name: 'Relapsing Polychondritis',
    document_type: 1,
    file: nil,
    tags: "relapsing_polychondritis rheumatic autoimmune_disease cartilage"
  },
  {
    name: 'Liver Disease',
    document_type: 1,
    file: nil,
    tags: "viral_infection alcohol environmental_toxins autoimmune_disease genetics"
  },
  {
    name: 'Malaria',
    document_type: 1,
    file: nil,
    tags: 'malaria Cambodia phnom_penh'
  },
  {
    name: 'HIV/AIDS',
    document_type: 1,
    file: nil,
    tags: 'AIDS female_prostitutes drugs HIV illegal'
  },
  {
    name: 'Dengue Fever',
    document_type: 1,
    file: nil,
    tags: "dengue mosquitos rainy_season cambodia"
  },
  {
    name: 'Tuberculosis',
    document_type: 1,
    file: nil,
    tags: "tuberculosis Cambodia airborne_infection lungs"
  },
  {
    name: 'Malnutrition',
    document_type: 1,
    file: nil,
    tags: 'malnutrition cambodia'
  },
  {
    name: 'Diarrhea diseases',
    document_type: 1,
    file: nil,
    tags: "UNICEF die diarrhea diseases annually"
  },
  {
    name: 'Stroke',
    document_type: 1,
    file: nil,
    tags: "stroke artery blocked leaks"
  },
  {
    name: 'Lower respiratory infections',
    document_type: 1,
    file: nil,
    tags: "lower_respiratory airways lungs."
  },
  {
    name: 'Chronic obstructive pulmonary disease',
    document_type: 1,
    file: nil,
    tags: "COPD lung_disease breathing_difficult chronic_bronchitis emphysema"
  },
  {
    name: 'Trachea, bronchus, and lung cancers',
    document_type: 1,
    file: nil,
    tags: "respiratory cancers trachea larynx bronchus lungs smoking smoke"
  },
  {
    name: 'Diabetes mellitus',
    document_type: 1,
    file: nil,
    tags: "Diabetes diseases insulin pancrease"
  },
  {
    name: 'Dehydration due to diarrheal diseases',
    document_type: 1,
    file: nil,
    tags: "Expsr burning cigarette subs"
  },
  {
    name: 'Tuberculosis',
    document_type: 1,
    file: nil,
    tags: "Dislocation interphaln joint of finger sequela"
  },
  {
    name: 'Cirrhosis',
    document_type: 1,
    file: nil,
    tags: 'Localized enlarged lymph nodes'
  },
  {
    name: 'h5n1',
    document_type: 1,
    file: nil,
    tags: "Malignant neoplasm genital organ"
  },
  {
    name: 'ទឹកនោមផ្អែម',
    document_type: 1,
    file: nil,
    tags: "ជំងឺ ទឹកនោមផែ្អម អ័រម៉ូន ក្រលៀន"
  },
  {
    name: 'ក្អកមាន់',
    document_type: 1,
    file: nil,
    tags: "ក្អក​មាន់ Pertussis whooping cough Coqueluche ក្មេង​តូចៗ"
  },
  {
    name: 'គ្រុនចាញ់',
    document_type: 1,
    file: nil,
    tags: "​គ្រុន​ចាញ់ មនុស្ស​គ្រប់​វ័យ ​រដូវ​ក្ដៅ ភ្នាក់​ងារ សត្វ​មូស​ដែក​គោលញី Anophèle"
  },
  {
    name: 'ផ្ដាសាយធម្មតា',
    document_type: 1,
    file: nil,
    tags: "ប្រយ័ត្ន​ ​រាង​កាយ ត្រូវ​អាកាសធាតុ​ត្រជាក់ សុខភាព កម្ពុជា"
  },
  {
    name: 'រោគព្រូន',
    document_type: 1,
    file: nil,
    tags: 'ព្រូន ​អាច​ចូល​មក ​ក្នុង​ខ្លួន​មនុស្ស​យើង ដផ្លែ​ឈើ បន្លែ​ស្រស់ សាច់​គោ សាច់​ជ្រូក ត្រី​មិន​ស្អាត'
  },
  {
    name: 'រោគមួល',
    document_type: 1,
    file: nil,
    tags: 'កម្ពុជា អ្នក​ជំងឺ​ឈឺ​រីងរៃ ​រោគ​ផ្សេងៗ​មក អនាម័យ'
  },
  {
    name: 'សរសៃប្រសាទ',
    document_type: 1,
    file: nil,
    tags: '​សរសៃ​ប្រសាទ ចិត្ត​គំនិត​របស់​អ្នក​ជំងឺ ខុស​ប្រក្រតី ត​ពូជ​គ្នា បុព្វជន​ក៏​ថា​បាន'
  },
  {
    name: 'គ្រុន​រលាក​ពោះ​វៀន',
    document_type: 1,
    file: nil,
    tags: 'រលាក​ពោះ​វៀន រោគ​នេះ​អាច​កើត​ដល់​ មនុស្ស​គ្រប់​វ័យ ​គ្រប់​ប្រភេទ'
  },
  {
    name: 'ជំងឺហើមសួត',
    document_type: 1,
    file: nil,
    tags: 'ហើមសួត មនុស្ស​គ្រប់​វ័យ គ្រប់​ប្រភេទ។'
  }
]


sops.each do |sop|
  s = Sop.new(sop)
  file = Rails.root.join('public', 'seed', sop[:file].to_s)

  if s.document? && file_exist?(file)
    File.open(file) { |f| s.file = f }
  end

  s.save
end


