<template>
  <div class="w-full h-full flex items-center justify-center left-0 top-0 absolute" v-if="Show">
    <div class="w-[69.3%] h-[68.5%] flex flex-col bg-main bg-no-repeat">
      <div class="w-full h-[17%] flex flex-wrap">
        <div class="w-[5%] h-full flex items-center justify-start">
        </div>
        <div class="w-[30%] h-full flex flex-col">
          <div class="w-full h-[50%] flex items-end justify-start pt-[.4vw]">
            <span class="header-name">24/7 Market</span>
          </div>
          <div class="w-full h-[50%] flex items-center justify-start pb-[.7vw]">
            <span class="header-minitext">One of the best markets in the world!</span>
          </div>
        </div>
        <div class="w-[55%] h-full"></div>
        <div class="w-[10%] h-full flex items-center justify-center">
          <img src="../assets/close-button.png" class="hover:cursor-pointer" @click="CloseUI()">
        </div>
      </div>
      <div class="w-full h-[5%]"></div>
      <div class="w-full h-[72%] flex items-center justify-center">
        <div class="w-[90%] h-full flex flex-wrap">
          <div class="w-[70%] h-full block overflow-x-hidden overflow-y-auto">
            <div class="w-[22%] h-[35%] flex flex-col float-left rounded-[0.3125vw] border-2 border-[#ffffff1f] ItemBox mr-[.5vw] mb-[.5vw]" v-for="v in MarketItems" :key="v.name">
              <div class="w-full h-[15%] flex items-center justify-start">
                <span class="w-full item-label">{{ v.label }}</span>
              </div>
              <div class="w-full h-[5%]"></div>
              <div class="w-full h-[50%] flex items-center justify-center">
                <img :src="'nui://'+InventoryIMGDirectory+'/'+v.name+'.png'" class="w-[3vw] h-[3vw]">
              </div>
              <div class="w-full h-[1%]"></div>
              <div class="w-full h-[12%] flex items-center justify-start">
                <span class="w-full price-text">{{ '$' + v.price }}</span>
              </div>
              <div class="w-full h-[15%] flex items-center justify-center">
                <div class="w-[90%] h-[90%] hover:cursor-pointer rounded-[.2vw]" style="background: rgba(255, 255, 255, 0.13);" @click="AddToCart(v)">
                  <span class="item-label" style="margin: 0 !important; font-size: .8vw !important;">Add To Cart</span>
                </div>
              </div>
            </div>
          </div>
          <div class="w-[29%] h-full flex flex-col cart-background">
            <div class="w-full h-[85%] flex items-end justify-center">
              <div class="w-[80%] h-[93%] block overflow-x-hidden overflow-y-auto">
                <div class="w-full h-[13%] flex flex-wrap mb-[.5vw] cart-item-background" v-for="v in CartItems" :key="v.name">
                  <div class="w-[20%] h-full flex items-center justify-center">
                    <img :src="'nui://'+InventoryIMGDirectory+'/'+v.name+'.png'" class="w-[1.5vw] h-[1.5vw]">
                  </div>
                  <div class="w-[5%] h-full"></div>
                  <div class="w-[20%] h-full flex items-center justify-start">
                    <span style="color: white; font-size: .8vw !important;">{{ v.label }}</span>
                  </div>
                  <div class="w-[20%] h-full flex items-center justify-center">
                    <span style="color: green; font-size: .8vw !important;">{{ '$' + v.price * v.count }}</span>
                  </div>
                  <div class="w-[35%] h-full flex items-center justify-between">
                    <div class="w-[33.33333%] h-full flex items-center justify-end">
                      <span class="hover:cursor-pointer" style="color: white; font-size: .8vw; margin-right: .1vw;" @click="CheckCart(v.name, true)">+</span>
                    </div>
                    <div class="w-[33.33333%] h-full flex items-center justify-center">
                      <span style="color: white; font-size: .8vw;">{{ 'x' + v.count }}</span>
                    </div>
                    <div class="w-[33.33333%] h-full flex items-center justify-start">
                      <span class="hover:cursor-pointer" style="color: white;  font-size: .8vw; margin-bottom: .2vw; margin-left: .1vw;" @click="CheckCart(v.name, false)">-</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="w-full h-[10%] flex flex-wrap">
              <div class="w-[50%] h-full flex items-center justify-center">
                <div class="w-[95%] h-full flex items-center justify-end">
                  <div class="w-[70%] h-[80%] flex items-center justify-center rounded-[.3vw] bg-green-800 hover:cursor-pointer" @click="Pay()">
                    <span style="color: white; font-size: .6vw; font-weight: 600;">Pay With Cash</span>
                  </div>
                </div>
              </div>
              <div class="w-[50%] h-full flex items-center justify-end">
                <span style="color: white; font-size: .9vw; font-weight: 600; margin-right: 1vw;">{{ '$' + CalculatePrice() }}</span>
              </div>
            </div>
            <div class="w-full h-[5%]"></div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'MainPage',
  data() {
    return {
      Show: false,
      resourceName: '',
      InventoryIMGDirectory: 'ps-inventory/html/images',
      MarketItems: [
        {name: 'water', label: 'Water', price: 1000},
        {name: 'bread', label: 'Bread', price: 500},
      ],
      CartItems: [],
      TotalPrice: 0,
    }
  },

  methods: {
    AddToCart(data) {
      const cartitems = this.CartItems.find(v => v.name === data.name)
      
      if (cartitems) {
        return;
      }

      const AddItem = {
        name: data.name, 
        label: data.label, 
        price: data.price,
        count: 1
      }
      this.CartItems.push(AddItem)
    },

    CheckCart(itemname, status) {
      const cartitems = this.CartItems.find(v => v.name === itemname)

      if (cartitems) {
        if (!status) {
          cartitems.count -= 1
          if (cartitems.count === 0) {
            this.CartItems.splice(this.CartItems.indexOf(cartitems), 1);
          }
        } else {
          cartitems.count += 1
        }
      }
    },

    CalculatePrice() {
      this.TotalPrice = this.CartItems.reduce((total, v) => total + (v.price * v.count), 0)
      return this.TotalPrice
    },  

    Pay() {
      if (this.CalculatePrice() > 0) {
        for (let i = 0; i < this.CartItems.length; i++) {
          const v = this.CartItems[i]
          this.postNUI('Pay', {
            item: v.name,
            count: v.count,
            price: this.CalculatePrice()
          })
        }
        this.TotalPrice = 0
        this.CartItems = []
      }
    },  

    CloseUI() {
      this.Show = false
      this.MarketItems = []
      this.InventoryIMGDirectory = ''
      this.TotalPrice = 0
      this.CartItems = []
      this.postNUI('CloseUI')
    },

    async postNUI(name, data) {
      try {
        const response = await fetch(`https://${this.resourceName}/${name}`, {
          method: "POST",
          mode: "cors",
          cache: "no-cache",
          credentials: "same-origin",
          headers: {
            "Content-Type": "application/json"
          },
          redirect: "follow",
          referrerPolicy: "no-referrer",
          body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
      } catch (error) {
        // console.log(error)
      }
    },
  },

  mounted() {
    window.addEventListener("message", (event) => {

      if (event.data.action == 'Setup') {
        this.resourceName = event.data.data
      }

      if (event.data.action == "OpenUI") {
        this.Show = true
        this.MarketItems = event.data.data
        this.InventoryIMGDirectory = event.data.inventoryimg
      }
    });
  },
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  ::-webkit-scrollbar {
    width: 0.1px;
  }

  ::-webkit-scrollbar-track {
    background: transparent;
  }

  ::-webkit-scrollbar-thumb {
    background: transparent;
  }

  ::-webkit-scrollbar-thumb:hover {
    background: transparent;
  }
  .header-name {
    color: #FFA800;
    font-size: 2vw;
    font-style: normal;
    font-weight: 700;
    line-height: normal;
  }

  .header-minitext {
    color: #FFF;
    font-size: 1.1881vw;
    font-style: normal;
    font-weight: 500;
    line-height: normal;
  }

  .ItemBox {
    background: radial-gradient(135.96% 135.96% at 50% 50%, rgba(255, 255, 255, 0.16) 0%, rgba(255, 255, 255, 0.00) 100%);
  }

  .item-label {
    color: #FFF;
    text-align: start;
    font-size: 0.8125vw;
    font-style: normal;
    font-weight: 500;
    padding-left: .5vw;
    padding-top: .5vw;
    line-height: 90%; /* 11.7px */
  }

  .price-text {
    color: #0F6;
    text-align: start;
    font-size: 0.8125vw;
    font-style: normal;
    font-weight: 500;
    padding-left: .5vw;
    line-height: 90%; /* 11.7px */
  }

  .cart-background {
    border-radius: .2604vw;
    border: .1042vw solid rgba(255, 255, 255, 0.08);
    background: radial-gradient(135.96% 135.96% at 50% 50%, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0.00) 100%);
  }

  .cart-item-background {
    border-radius: .3125vw;
    border: .1042vw solid rgba(255, 255, 255, 0.06);
    background: radial-gradient(135.96% 135.96% at 50% 50%, rgba(255, 255, 255, 0.05) 0%, rgba(255, 255, 255, 0.00) 100%);
  }
</style>
