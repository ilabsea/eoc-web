Sop.destroy_all
Category.destroy_all

categories = [
  {
    name: 'cat 1',
    children: [
      {
        name: 'cat 1.1',
        children: [
          {
            name: 'cat 1.1.1'
          },
          {
            name: 'cat 1.1.2'
          }
        ],
        sops: [
          {
            name: 'sop 1.1',
            file: 'sop-1.1.zip'
          }
        ]
      },
      {
        name: 'cat 1.2',
        children: [
          {
            name: 'cat 1.2.1'
          }
        ],
        sops: []
      },
      {
        name: 'cat 1.3',
        children: [
          {
            name: 'cat 1.3.1'
          },
          {
            name: 'cat 1.3.2'
          },
          {
            name: 'cat 1.3.3'
          }
        ],
        sops: [
          {
            name: 'sop 1.3.11',
            file: 'sop-1.3.11.rar'
          }
        ]
      }
    ],
    sops: [
      {
        name: 'sop 1.1',
        file: 'sop-1.1.pdf'
      },
      {
        name: 'sop 1.22',
        file: 'sop-1.22.rar'
      },
      {
        name: 'sop 1.3',
        file: nil
      }
    ]
  },

  {
    name: 'cat 2',
    children: [
      {
        name: 'cat 2.1',
        children: [
          {
            name: 'cat 2.1.1'
          },
          {
            name: 'cat 2.1.2'
          }
        ],
        sops: [
          {
            name: 'sop 2.1',
            file: 'sop-2.1.docx'
          }
        ]
      },
      {
        name: 'cat 2.2',
        children: [
          {
            name: 'cat 2.2.1'
          }
        ],
        sops: [
          {
            name: 'sop 2.2',
            file: 'sop-2.2.xlsx'
          }
        ]
      },
      {
        name: 'cat 2.3',
        children: [
          {
            name: 'cat 2.3.1'
          },
          {
            name: 'cat 2.3.2'
          },
          {
            name: 'cat 2.3.3'
          }
        ],
        sops: [
          {
            name: 'sop 2.3',
            file: nil
          }
        ]
      },
      {
        name: 'cat 2.4',
        children: [],
        sops: [
          {
            name: 'sop 2.4',
            file: 'sop-2.4.pdf'
          }
        ]
      }
    ],
    sops: [
      {
        name: 'sop 2',
        file: 'sop-2.docx'
      }
    ]
  }
]

categories.each do |cat1|
  _cat1 = Category.create name: cat1[:name]

  cat1[:children].each do |cat2|
    _cat2 = Category.new name: cat2[:name]
    _cat1.children << _cat2
    cat2[:children].each do |cat3|
      _cat3 = Category.new name: cat3[:name]
      _cat2.children << _cat3
    end

    cat2[:sops].each do |sop2|
      _sop2 = Sop.new name: sop2[:name]
      file_path = Rails.root.join('public', 'seed', 'sops')
      _sop2.with_attachment(file_path, sop2[:file]) do |f|
        _sop2.file = f
      end
    end
  end

  cat1[:sops].each do |sop1|
    _sop1 = Sop.new name: sop1[:name]

    file_path = Rails.root.join('public', 'seed', 'sops')
    _sop1.with_attachment(file_path, sop1[:file]) do |f|
      _sop1.file = f
    end
  end
end
