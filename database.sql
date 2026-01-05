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
    course_id INTEGER REFERENCES courses (id)
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
