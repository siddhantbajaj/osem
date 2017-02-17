namespace :data do
  desc 'Create demo data using our factories'
  task demo: :environment do
    include FactoryGirl::Syntax::Methods

    conference = create(:full_conference, title: 'Open Source Event Manager Demo', short_title: 'osemdemo' ,description: "This is a [Open Source Event Manager](http://osem.io/) demo instance. You can log in as **admin** with the password **password123** or just you just [sign up](/accounts/sign_up) with your own user. We hope you enjoy checking out all the functionality, if you have questions don't hesitate to [contact us](http://osem.io/#contact)!\r\n\r\n## Data will be destroyed every thirty minutes or whenever someone updates the [OSEM source code on github](https://github.com/openSUSE/osem/commits/master).")
    conference.contact.update_attributes(email: 'osemdemo@osem.io', sponsor_email: 'osemdemo@osem.io')
    create(:admin, email: 'admin@osem.io', username: 'admin', password: 'password123', password_confirmation: 'password123')
    #Demo Events
    program_id = conference.program.id
    create(:event, program_id: program_id, title: 'Demo Event', abstract: 'This is a [Open Source Event Manager](http://osem.io/) demo event instance')
    create(:event, program_id: program_id, title: 'Demo Rejected Event', state: 'rejected', abstract: 'This is a [Open Source Event Manager](http://osem.io/) demo event instance')
    create(:event, program_id: program_id, title: 'Demo Unconfirmed Event', state: 'unconfirmed', abstract: 'This is a [Open Source Event Manager](http://osem.io/) demo event instance')
    create(:event, program_id: program_id, title: 'Demo Confirmed Event', state: 'confirmed', abstract: 'This is a [Open Source Event Manager](http://osem.io/) demo event instance')
    event = create(:event, program_id: program_id, title: 'Demo Scheduled Event', state: 'confirmed', abstract: 'This is a [Open Source Event Manager](http://osem.io/) demo event instance')
    create(:event_schedule, event_id: event.id)
  end
end
