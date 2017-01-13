package com.endava.todolist.dao;

import com.endava.todolist.entity.Item;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class ItemDAOImpl implements ItemDAO {

    private SessionFactory sessionFactory;

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    public void addItem(Item item) {
        Session session = this.sessionFactory.getCurrentSession();
        session.persist(item);
    }

    public void editItem(Item item) {
        Session session = this.sessionFactory.getCurrentSession();
        session.update(item);
    }

    public void deleteItem(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        session.createSQLQuery("delete from item").executeUpdate();
    }

    public Item getItemById(int id) {
        Session session = this.sessionFactory.getCurrentSession();
        Item item = (Item) session.get(Item.class, id);
        return item;
    }

    @SuppressWarnings("unchecked")
    public List<Item> listItems() {
        Session session = this.sessionFactory.getCurrentSession();
        List<Item> list = session.createQuery("from Item").list();
        return list;
    }

}
