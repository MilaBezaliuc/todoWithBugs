package com.endava.todolist.controller;

import com.endava.todolist.entity.Item;
import com.endava.todolist.service.ItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


@Controller
public class ItemController {

    private ItemService itemService;

    @Autowired(required = true)
    @Qualifier(value = "itemService")
    public void setItemService(ItemService itemService) {
        this.itemService = itemService;
    }

    @RequestMapping(value = "todolist", method = RequestMethod.GET)
    public String listItems(Model model) {
        model.addAttribute("item", new Item());
        model.addAttribute("listItems", this.itemService.listItems());
        return "todolist";
    }

    @RequestMapping(value = "/todolist/add", method = RequestMethod.POST)
    public String addItem(@ModelAttribute("item") Item item) {
        if (item.getId() == 0) {
            this.itemService.addItem(item);
        } else {
            this.itemService.editItem(item);
        }
        return "redirect:/todolist";
    }

    @RequestMapping(value = "/delete/{id}")
    public String deleteItem(@PathVariable("id") int id) {
        this.itemService.deleteItem(id);
        return "redirect:/todolist";
    }

    @RequestMapping(value = "/edit/{id}")
    public String editItem(@PathVariable("id") int id, Model model) {
        model.addAttribute("item", this.itemService.getItemById(id));
        model.addAttribute("listItems", this.itemService.listItems());
        return "todolist";
    }

    @RequestMapping(value = "/sortedlist/")
    public String sortItems(@RequestParam(value = "showDone") boolean showDone, Model model) {
        model.addAttribute("item", new Item());
        model.addAttribute("listItems", this.itemService.sortItems(showDone));
        return "todolist";
    }

}
