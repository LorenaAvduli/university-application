Rails.application.routes.draw do

  scope :instructor do
    resources :assessment_items
    resources :courses do
      member do
        get 'register_student', as: :register_student
        post 'register/data', to: 'courses#register', as: :register
      end
    end
    resources :grades do
      collection do
        get 'assessment_items', as: :assessment_items
        get 'courses', as: :courses
      end
    end

    get '/', to: 'instructor#home', as: :home_page

    scope :students do
      get '/', to: 'instructor#index', as: :students
      get '/new', to: 'instructor#new', as: :new_student
      post '/', to: 'instructor#create'
      get '/:id', to: 'instructor#show', as: :student
      get '/:id/edit', to: 'instructor#edit', as: :edit_student
      patch '/:id', to: 'instructor#update'
      delete '/:id', to: 'instructor#destroy'
      delete '/:id/remove_student', to: 'instructor#remove_student_course', as: :remove_student_course
    end
  end

  scope :student do
    get '/', to: 'student#home', as: :student_page
    get '/grades', to: 'student#grades', as: :student_grades
  end
  # devise_for :users
  devise_for :users, controllers: { sessions: "users/sessions",
                                            registrations: "users/registrations",
                                            passwords: "users/passwords" }
  get '/welcome', to: "home#index", as: :root
  get '/course/:id/assessment_items', to: 'home#assessment_items', as: :course_assessment_items
end
