return unless Rails.env == 'development'

conn = ActiveRecord::Base.connection


Category.__elasticsearch__.create_index!(force: true)
Sop.__elasticsearch__.create_index!(force: true)

conn.execute('DELETE FROM categories;')
conn.execute('DELETE FROM sops;')

Sop.all.map &:remove_file!

def create_sop sop
  _sop = Sop.new name: sop[:name], tags: sop[:tags], description: sop[:description]
  file_path = Rails.root.join('public', 'seed', 'sops')
  _sop.with_attachment(file_path, sop[:file]) do |f|
    _sop.file = f
  end

  p _sop.errors.full_messages unless _sop.save
  _sop
end

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
            name: 'cat 1 as sop',
            tags: ['#tag1', '#tag2', '#tag3'],
            description: 'some description cat 1 as sop',
            file: 'cat-1-as-sop.zip'
          },
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
            tags: ['#tag1', '#tag2', '#tag3'],
            description: 'some description cat 1 as sop',
            file: 'sop-1.3.11.zip'
          }
        ]
      }
    ],
    sops: [
      {
        name: 'sop 1.12',
        tags: ['#tag1', '#tag2', '#tag3'],
        description: 'some description cat 1 as sop',
        file: 'sop-1.1.pdf'
      },
      {
        name: 'sop 1.22',
        tags: ['#tag1', '#tag2', '#tag3'],
        description: 'some description cat 1 as sop',
        file: 'sop-1.22.zip'
      },
      {
        name: 'sop 1.3',
        tags: ['#tag1', '#tag2', '#tag3'],
        description: 'some description cat 1 as sop',
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
            tags: ['#tag1', '#tag2', '#tag3'],
            description: 'some description cat 1 as sop',
            file: 'sop-2.1.pdf'
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
            tags: ['#tag1', '#tag2', '#tag3'],
            description: 'some description cat 1 as sop',
            file: 'sop-2.2.pdf'
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
            tags: ['#tag1', '#tag2', '#tag3'],
            description: 'some description cat 1 as sop',
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
            tags: ['#tag1', '#tag2', '#tag3'],
            description: 'some description cat 1 as sop',
            file: 'sop-2.4.pdf'
          }
        ]
      }
    ],
    sops: [
      {
        name: 'sop 2',
        tags: ['#tag1', '#tag2', '#tag3'],
        description: 'some description cat 1 as sop',
        file: 'sop-2.pdf'
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
      _cat2.sops << create_sop(sop2)
    end
  end

  cat1[:sops].each do |sop1|
    _cat1.sops << create_sop(sop1)
  end
end
