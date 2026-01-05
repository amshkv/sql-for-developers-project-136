CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255),
    description TEXT,
    state VARCHAR(255),
    crated_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    body TEXT,
    video_link TEXT,
    order_index INTEGER,
    state VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    course_id BIGINT REFERENCES courses (id)
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255),
    description TEXT,
    state VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE module_items (
    course_id BIGINT NOT NULL REFERENCES courses (id),
    module_id BIGINT NOT NULL REFERENCES modules (id),
    PRIMARY KEY (module_id, course_id)
);

CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(255),
    price INTEGER,
    kind VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE program_items (
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
    username VARCHAR(255),
    email VARCHAR(255),
    password_digest VARCHAR(255),
    kind VARCHAR(255),
    teaching_group_id BIGINT REFERENCES teaching_groups (id),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE enr_state AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TABLE enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    state ENR_STATE
);

CREATE TYPE payment_state AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TABLE payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES enrollments (id) NOT NULL,
    state PAYMENT_STATE,
    payment_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TYPE com_state AS ENUM ('active', 'completed', 'pending', 'cancelled');

CREATE TABLE program_completions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    state COM_STATE,
    started_at TIMESTAMP,
    ended_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users (id) NOT NULL,
    program_id BIGINT REFERENCES programs (id) NOT NULL,
    url VARCHAR(255),
    publish_date TIMESTAMP,
    crated_at TIMESTAMP,
    updated_at TIMESTAMP
);
