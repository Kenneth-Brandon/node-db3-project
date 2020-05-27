const db = require('../data/dbConfig');

const find = () => db('schemes');

const findById = (id) => db('schemes').where({ id }).first();

const findSteps = (scheme_id) => {
  return db('steps as st')
    .select('st.id', 'sc.scheme_name', 'st.step_number', 'st.instructions')
    .join('schemes as sc', 'st.scheme_id', 'sc.id')
    .where({ scheme_id })
    .orderBy('step_number');
};

const add = async (newScheme) => {
  const [id] = await db('schemes').insert(newScheme);

  return findById(id);
};

const update = async (changes, id) => {
  await db('schemes').update(changes).where({ id });

  return findById(id);
};

const remove = async (id) => {
  const toRemove = await findById(id);

  await db('schemes').del().where({ id });

  return new Promise((resolve) => resolve(toRemove));
};

const addStep = async (step, scheme_id) => {
  const [id] = await db('steps').insert({ scheme_id, ...step });

  return db('steps').where({ id }).first();
};

module.exports = { find, findById, findSteps, add, update, remove, addStep };
