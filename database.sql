CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description TEXT,
    deleted_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    content TEXT,
    video_url TEXT,
    position INTEGER,
    deleted_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    course_id BIGINT REFERENCES courses (id)
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description TEXT,
    deleted_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE course_modules (
    course_id BIGINT NOT NULL REFERENCES courses (id),
    module_id BIGINT NOT NULL REFERENCES modules (id),
    PRIMARY KEY (module_id, course_id)
);

CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    price INTEGER,
    program_type VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE program_modules (
    module_id BIGINT NOT NULL REFERENCES modules (id),
    program_id BIGINT NOT NULL REFERENCES programs (id),
    PRIMARY KEY (program_id, module_id)
);

CREATE TABLE teaching_groups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    email VARCHAR(255),
    password_hash VARCHAR(255),
    role VARCHAR(255),
    teaching_group_id BIGINT REFERENCES teaching_groups (id),
    deleted_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE enr_status AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TABLE enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    status ENR_STATUS
);

CREATE TYPE payment_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES enrollments (id) NOT NULL,
    status PAYMENT_STATUS,
    paid_at TIMESTAMP,
    amount INTEGER,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE com_status AS ENUM ('active', 'completed', 'pending', 'cancelled');

CREATE TABLE program_completions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    status COM_STATUS,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    url VARCHAR(255),
    issued_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons (id) NOT NULL,
    name VARCHAR(255),
    content JSONB,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons (id) NOT NULL,
    name VARCHAR(255),
    url VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE discussions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons (id) NOT NULL,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    text JSONB,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE post_status AS ENUM (
    'created',
    'in moderation',
    'published',
    'archived'
);

CREATE TABLE blogs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    name VARCHAR(255),
    content TEXT,
    status POST_STATUS,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
