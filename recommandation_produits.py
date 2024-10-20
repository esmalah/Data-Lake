from pyspark.sql import SparkSession
from pyspark.ml.recommendation import ALS

spark = SparkSession.builder.appName("ProductRecommendation").enableHiveSupport().getOrCreate()
orders_df = spark.sql("SELECT customer_id, product_id, quantity FROM fait_orders")

# Créer le modèle de recommandation ALS
als = ALS(userCol="customer_id", itemCol="product_id", ratingCol="quantity", coldStartStrategy="drop")
model = als.fit(orders_df)

# Faire des recommandations pour chaque utilisateur
user_recs = model.recommendForAllUsers(10)
user_recs.write.csv("/path/to/output/recommandations_clients.csv")
