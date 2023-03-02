#  dependences
require 'sinatra'
require 'pg'
require 'bcrypt'

if development?
  require 'sinatra/reloader' 
  require 'pry'

end


enable :sessions




def logged_in?()
  if session[:doctor_id]
    return true
  else
    return false
  end
end


def current_doctor
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'clinidocs'})
  sql = "SELECT * FROM doctors WHERE id = #{session[:doctor_id]};"

  results = db.exec(sql)
  return results[0]
end

def run_sql(sql, arr = [])
  db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'clinidocs'})
  results = db.exec_params(sql, arr)
  db.close
  return results

end



get '/' do
  redirect '/login' unless logged_in?

  patients = run_sql('SELECT * FROM patients;')
  erb :index, locals: { patients: patients }
end

# get '/treatment_notes' do
#   redirect '/login' unless logged_in?

#   treatment_notes = run_sql('SELECT * FROM treatment_notes;')
#   erb :treatment_notes, locals: {treatment_notes:treatment_notes}
# end

get '/login' do
  erb :login
end


get '/patients/:id' do
 
  patient = run_sql("SELECT * FROM patients WHERE id = $1;", [params[:id]])[0]
  erb :patient_details, locals: { patient: patient }
end


post '/patients' do
  redirect '/login' unless logged_in?

  sql = "insert into patients (name, contact_details, address, medicare_number, date_of_birth, height, weight, blood_type) values ($1, $2, $3, $4, $5, $6, $7, $8)"
  run_sql(sql, [
    params[:name], 
    params[:contact_details], 
    params[:address],
    params[:medicare_number],
    params[:date_of_birth],
    params[:height],
    params[:weight],
    params[:blood_type],
    current_doctor()['id']
  ])

  redirect '/'
end



post '/sessions' do

    db = PG.connect(ENV['DATABASE_URL'] || {dbname: 'clinidocs'})
    sql = "SELECT * FROM doctors WHERE email = '#{params[:email]}';"
    results = db.exec(sql) 

    if results.count == 1 && BCrypt::Password.new(results[0]['password_digest']).==(params[:password])
      
      session[:doctor_id] = results[0]['id']
      redirect('/')
    else  
      erb :login
    end
  
end




delete '/sessions' do
  session[:doctor_id] = nil
  redirect '/login'
end



get '/treatment_notes/:id' do
 
  treatment_note = run_sql("SELECT * FROM treatment_notes WHERE id = $1;", [params[:id]])[0]
  erb :treatment_note, locals: { treatment_note: treatment_note }
end




get '/new_pt' do
  erb :new_pt
end

post '/patient_details' do

  sql = "insert into patients (name, surname, contact_details, address, medicare_number, date_of_birth, height, weight, blood_type) values ($1, $2, $3, $4, $5, $6, $7, $8, $9)"
  run_sql(sql, [
    params[:name], 
    params[:surname],
    params[:contact_details], 
    params[:address],
    params[:medicare_number],
    params[:date_of_birth],
    params[:height],
    params[:weight],
    params[:blood_type],
  ])

  redirect '/'
end


delete '/patients/:id' do
  
  
  patient = run_sql("DELETE FROM patients WHERE id = $1;", [params[:id]])[0]

  
  redirect('/')
end



get '/edit_patient/:id' do
  patient = run_sql("select * from patients where id = $1;", [params[:id]])[0]
  erb :edit_patient, locals: { patient: patient }
end


# patch '/patients/:id' do
#   sql = "update patients set name = $1, surname = $2, contact_details = $3, address = $4, medicare_number = $5, date_of_birth = $6, height = $7, weight = $8, blood_type = $9 where id = $10;", 
  
#   run_sql(sql, [
#     params[:name], 
#     params[:surname],
#     params[:contact_details], 
#     params[:address],
#     params[:medicare_number],
#     params[:date_of_birth],
#     params[:height],
#     params[:weight],
#     params[:blood_type],
#     params[:id]
#   ])

#   redirect "/patients/#{params[:id]}"
# end

patch '/patients/:id' do
 
  run_sql(
    "update patients set name = $1, surname = $2, address = $3, date_of_birth = $4, contact_details = $5, medicare_number = $6, height = $7, weight = $8, blood_type = $9 where id = $10;", 
    [params[:name], params[:surname],params[:address],params[:date_of_birth],params[:contact_details], params[:medicare_number], params[:height], params[:weight], params[:blood_type], params[:id]]
  )

  redirect "/patients/#{params[:id]}"

end

# get '/treatment_notes/:id' do
 
#   treatment_note = run_sql("SELECT * FROM treatment_notes WHERE id = $1;", [params[:id]])[0]
#   erb :treatment_notes, locals: { treatment_note: treatment_note }
# end


get '/notes' do
  erb :notes
end


get '/new_tn' do
  patient_id = params['patient_id']
  erb :new_tn, locals: { patient_id: patient_id }
end

# get '/new_tn'
# sql = "select * from treatment_notes where patient = $1"
# treatment_notes = run_sql(sql, [params[:patient]])
# erb :treatment_notes, locals: { treatment_notes: treatment_notes}

get '/treatment_notes' do
  sql = "select * from treatment_notes where patient_id = $1"
  treatment_notes = run_sql(sql, [params[:patient_id]])
  erb :treatment_notes, locals: { treatment_notes: treatment_notes }
end


post '/treatment_notes' do

  sql = "insert into treatment_notes (patient_id, medication_history, medical_history, images, results) values ($1, $2, $3, $4, $5)"
  run_sql(sql, [
    params[:patient_id], 
    params[:medication_history],
    params[:medical_history], 
    params[:images],
    params[:results],
  ])

  redirect '/'
end

get '/treatment_note' do
  treatment_note = run_sql("SELECT * FROM treatment_notes;")
  erb :treatment_note, locals: { treatment_note: treatment_note }
end

# get '/search' do
#   erb :search
# end

