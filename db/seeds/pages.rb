Spree::Page.create!(
	title: 'About NMTx',
	slug:  'about',
	body:  "<p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>",
     show_in_header: true
)

Spree::Page.create!(
	title: 'Careers',
	slug:  'careers',
	body:  "<p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>
          <p> #{ Faker::Lorem.paragraphs( rand( 5..10 ) ).join( ' ' ) } </p>",
     show_in_header: true
)